resource "aws_eip" "eip_for_nat_gateway_1" {
  domain   = "vpc"
    tags = {
      Name = "nat gateway 1 eip"
    }
}

resource "aws_eip" "eip_for_nat_gateway_2" {
  domain   = "vpc"
    tags = {
      Name = "nat gateway 2 eip"
    }
}

resource "aws_nat_gateway" "aws_nat_gateway_1" {
 allocation_id = aws_eip.eip_for_nat_gateway_1.id
 subnet_id = var.public_subnet_1

 tags = {
   Name = "nat gateway 1"
 }

 depends_on = [ var.internet_gateway ]
}

resource "aws_nat_gateway" "aws_nat_gateway_2" {
 allocation_id = aws_eip.eip_for_nat_gateway_2.id
 subnet_id = var.public_subnet_2

 tags = {
   Name = "nat gateway 2"
 }

 depends_on = [ var.internet_gateway ]
}

resource "aws_route_table" "private_route_table_1" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.aws_nat_gateway_1.id
  }

  tags = {
    Name = "private_route_table_1"
  }
}

resource "aws_route_table_association" "private_app_subnet1_route_table_association" {
  subnet_id = var.private_app_subnet_1
  route_table_id = aws_route_table.private_route_table_1.id
}

resource "aws_route_table_association" "private_data_subnet1_route_table_association" {
  subnet_id = var.private_data_subnet_1
  route_table_id = aws_route_table.private_route_table_1.id
}

resource "aws_route_table" "private_route_table_2" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.aws_nat_gateway_2.id
  }

  tags = {
    Name = "private_route_table_2"
  }
}

resource "aws_route_table_association" "private_app_subnet2_route_table_association" {
  subnet_id = var.private_app_subnet_2
  route_table_id = aws_route_table.private_route_table_2.id
}

resource "aws_route_table_association" "private_data_subnet2_route_table_association" {
  subnet_id = var.private_data_subnet_2
  route_table_id = aws_route_table.private_route_table_2.id
}