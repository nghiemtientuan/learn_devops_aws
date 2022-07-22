#Common variable
variable "system_code" {
  description = "code for system"
  type = string 
  default = "mysystem"
}
variable "env_code" {
  description = "code for environment"
  type = string 
  default = "dev"
}
variable "region_code" {
  type = string
  description = "Code for system region, example: virginia"
  default = "virginia"
}

#Database variables
variable "db_subnet_ids" {
  description = "Subnets ids for database"
  type =  list
}
variable "db_security_group_id" {
  description = "Security group id for database"
  type =  string
}
variable "db_instance_class" {
  description = "Instance type for database"
  type =  string
}
variable "db_engine" {
  description = "Engine for database"
  type =  string
  default = "aurora-mysql"
}
variable "db_engine_version" {
  description = "DB Engine version"
  type =  string
  default = "8.0"
}
variable "db_database_name" {
  type = string
  description = "Database name"
  default = "postgres-db"
}
variable "db_master_username" {
  description = "Master username for DB"
  type =  string
}
variable "db_master_password" {
  description = "Master password for DB"
  type =  string
}
variable "db_backup_windows" {
  type = string
  description = "Backup windows for DB in UTC time. Example: 20:00-22:00"
  default = "20:00-22:00"
}
variable "db_number_of_reader_node" {
  description = "Number of reader node for database"
  type =  number
  default = 1
}
variable "db_skip_final_snapshot" {
  description = "Skip final snapshot when delete or not"
  type = bool
  default = false
}

# Application LoadBalancer Variable
variable "alb_vpc_id" {
  description = "ID of VPC"
  type = string
}
variable "alb_subnet_ids" {
  description = "ID of subnets for Application load balancer. Should be public subnet 1,2"
  type = list
}
variable "alb_security_group_ids" {
  description = "ID of Security Group for Application load balancer. Should be public security group"
  type = list
}