output "region" {
  value = var.region
}

output "project_name" {
  value = var.project_name
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_1" {
  value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2" {
  value = aws_subnet.public_subnet_2.id
}

output "private_app_subnet_1" {
  value = aws_subnet.private_app_subnet_1.id
}

output "private_app_subnet_2" {
  value = aws_subnet.private_app_subnet_2.id
}

output "private_data_subnet_1" {
  value = aws_subnet.private_data_subnet_1.id
}

output "private_data_subnet_2" {
  value = aws_subnet.private_data_subnet_2.id
}

output "internet_gateway" {
  value = aws_internet_gateway.internet_gateway.id
}