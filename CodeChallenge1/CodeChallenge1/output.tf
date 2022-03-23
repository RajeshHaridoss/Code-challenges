output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_sg" {
  description = "Public Subnet Security Group"
  value       =  module.ec2_sg.public_subnet_sg
}

output "public_subnets_ids" {
  description = "all public subnets"
  value    = module.public_subnet.subnet_ids
}

output "private_subnets_ids" {
  description = "all private subnets"
  value    = module.private_subnet.subnet_ids
}

