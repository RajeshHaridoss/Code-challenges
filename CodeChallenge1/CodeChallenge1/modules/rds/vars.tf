# RDS - Postgres

variable "rds_identifier" {
  default = "db"
}

variable "rds_instance_type" {
  default = "db.t2.micro"
}

variable "rds_storage_size" {
  default = "5"
}

variable "rds_engine" {
  default = "postgres"
}

variable "rds_engine_version" {
  default = "10.17"
}

variable "rds_db_name" {
  default = "rds_db"
}

variable "rds_admin_user" {
  default = "dbadmin"
}

variable "rds_admin_password" {
  default = "super_secret_password"
}

variable "rds_publicly_accessible" {
  default = "false"
}

variable "subnet_ids" {
  type   = set(string)
  description = "list of private subnets"
}

variable "vpc_id" {
  type   = string
  description = "vpc id"
}

variable "project" {
  description = "Project Name"
  type        = string
}
variable "env" {
  description = "Environment Name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}