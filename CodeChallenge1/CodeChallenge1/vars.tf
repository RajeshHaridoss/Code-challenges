variable "project" {
  description = "Project Name"
  type        = string
}
variable "env" {
  description = "Environment Name"
  type        = string
}
variable "region" {
  description = "AWS Region"
  type        = string
}

variable "cidr_block" {
  description = "CIDR for vpc"
  type        = string
}
variable "public_cidr" {
  description = "List of public subnets for the VPC"
  type        = list(string)
}
variable "private_cidr" {
  description = "List of private subnets for the VPC"
  type        = list(string)
}

variable "azs" {
  description = "List of availability zones names in the region"
  type        = list(string)
}

variable "aws_region" {
  type = string
  default = "eu-west-2" 
}

variable "ec2_amis" {
  description = "ami to support t2-micro instance"
  type        = map(string)

  default = {
    "eu-west-2" = "ami-f976839e"
    }
}

variable "instance_type" {
  default = "t2.micro"
}




