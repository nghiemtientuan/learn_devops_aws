# ami = "ami-052efd3df9dad4825"
# instance_type = "t2.micro"
# name = "Day6-Demo-Instance"
# key_name = "learn-depop-us-east-1"
# vpc_id = "vpc-0974ddf8174083e9a"
# subnet_id = "subnet-0905d1b1aa4d7ebe1"
variable "ami" {
  default = "ami-052efd3df9dad4825"
  type = string
  description = "AMI id for ec2"
}

variable "instance_type" {
  default = "t2.micro"
  type = string
  description = "instance_type"
}

variable "name" {
  default = "Day6-Demo-Instance"
  type = string
  description = "name"
}

variable "key_name" {
  default = "learn-depop-us-east-1"
  type = string
  description = "key_name"
}

variable "vpc_id" {
  default = "vpc-0974ddf8174083e9a"
  type = string
  description = "vpc_id"
}

variable "subnet_id" {
  default = "subnet-0905d1b1aa4d7ebe1"
  type = string
  description = "subnet_id"
}
