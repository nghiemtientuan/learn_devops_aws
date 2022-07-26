terraform {
  required_version = ">= 0.12.6"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  profile = "default"
  shared_credentials_file = "~/.aws/credentials"
}

locals {
  name        = "test_ecs"
  environment = "prod"
  common_tags = {
    Project = "demo"
    Env     = local.environment
  }
}

module "common_sg" {
  source = "../../module/common_sg"

  vpc_id = module.vpc.vpc_id
  depends_on = [
    module.vpc
  ]
}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]

  #   enable_nat_gateway = true
  #   enable_vpn_gateway = true

  tags = local.common_tags

}

data "aws_security_group" "default_sg" {
  vpc_id = module.vpc.vpc_id

  filter {
    name   = "group-name"
    values = ["default"]
  }
}

resource "aws_ecs_service" "service" {
  name            = "main_service"
  cluster         = module.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_def.arn
  desired_count   = 1

  network_configuration {
    subnets          = module.vpc.public_subnets
    security_groups  = [module.common_sg.allow_http.id, data.aws_security_group.default_sg.id]
    assign_public_ip = true
  }

  # ordered_placement_strategy {
  #   type  = "binpack"
  #   field = "cpu"
  # }

  load_balancer {
    target_group_arn = module.alb.alb_backend_service_targetgroup_arn
    container_name   = "nginx"
    container_port   = 80
  }

  # placement_constraints {
  #   type       = "memberOf"
  #   expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  # }
}

module "ecs_cluster" {
  source = "../../module/ecs_cluster"

  name               = local.name
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy = [{
    capacity_provider = "FARGATE"
    weight            = 1
    base              = 0
  }]

  tags = {
    Environment = local.environment
  }
}


resource "aws_ecs_task_definition" "task_def" {
  family                = "service"
  container_definitions = file("../../../task_def/nginx-php-revision2.json")

  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  execution_role_arn = module.ecs_cluster.taskExecRoleArn
  task_role_arn      = module.ecs_cluster.taskExecRoleArn
}

module "database" {
  source = "../../module/database"
  system_code   = var.system_code
  env_code      = var.env_code

  db_subnet_ids = module.vpc.private_subnets
  db_security_group_ids = [module.common_sg.allow_mysql.id]
  db_instance_class = var.db_instance_class
  db_engine = var.db_engine
  db_engine_version = var.db_engine_version
  db_database_name = var.db_database_name
  db_master_username = var.db_master_username
  db_master_password = var.db_master_password
  db_backup_windows = var.db_backup_windows
  db_number_of_reader_node = var.db_number_of_reader_node
  db_skip_final_snapshot = var.db_skip_final_snapshot
  depends_on = [
    module.common_sg,
    module.vpc
  ]
}

#Module ALB
module "alb" {
  source = "../../module/alb"
  system_code   = var.system_code
  env_code      = var.env_code

  alb_vpc_id = module.vpc.vpc_id
  alb_subnet_ids = module.vpc.public_subnets
  alb_security_group_ids = [module.common_sg.allow_http.id]

  depends_on = [
    module.database,
    module.vpc,
    module.common_sg
  ]
}
