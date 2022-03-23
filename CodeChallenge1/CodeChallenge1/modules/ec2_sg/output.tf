output "public_subnet_sg" {
  description = "Public Subnet Security Group"
  value       = aws_security_group.default_public.id
}