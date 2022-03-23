variable "azs" {
  description = "List of availability zones names in the region"
  type        = list(string)
}
variable "project" {
  description = "Project Name"
  type        = string
}
variable "env" {
  description = "Environment Name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type = string
}

variable "subnet_ids" {
  description = "list of all subnets created"
  type = list(string)
}


