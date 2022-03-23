output "subnet_ids" {
    value = aws_subnet.subnet.*.id
}

/*
output "public_subnet_0" {
  description = "Public Subnet 0"
  value       = aws_subnet.subnet[0].id
}
output "public_subnet_1" {
  description = "Public Subnet 1"
  value       = aws_subnet.subnet[1].id
}
output "public_subnet_2" {
  description = "Public Subnet 2"
  value       = aws_subnet.subnet[2].id
}
*/