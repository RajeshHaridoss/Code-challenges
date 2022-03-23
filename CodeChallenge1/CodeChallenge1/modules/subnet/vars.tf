variable "subnets" {
  description = "List of public/private cidr block"
  type        = list(string)
}
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

