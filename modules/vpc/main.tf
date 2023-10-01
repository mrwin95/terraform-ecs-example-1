# create vpc

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id
    tags = {
      Name = "${var.project_name}-igw"
    }
}

# use to get all availability zones

data "aws_availability_zones" "aws_availability_zones" {
  
}

resource "aws_subnet" "public_subnet_1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_1_cidr
    availability_zone = data.aws_availability_zones.aws_availability_zones.names[0]
    map_public_ip_on_launch = true

    tags = {
      Name = "public_subnet_1"
    }
}

resource "aws_subnet" "public_subnet_2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_2_cidr
    availability_zone = data.aws_availability_zones.aws_availability_zones.names[1]
    map_public_ip_on_launch = true

    tags = {
      Name = "public_subnet_2"
    }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = var.public_route_table_cidr
        gateway_id = aws_internet_gateway.internet_gateway.id
    }

    tags = {
      Name = "public_route_table"
    }
}

resource "aws_route_table_association" "public_subnet_1_route_table_assosication" {
    subnet_id = aws_subnet.public_subnet_1.id
    route_table_id = aws_route_table.public_route_table.id    
}

resource "aws_route_table_association" "public_subnet_2_route_table_assosication" {
    subnet_id = aws_subnet.public_subnet_2.id
    route_table_id = aws_route_table.public_route_table.id    
}

resource "aws_subnet" "private_app_subnet_1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_app_subnet_1_cidr
    availability_zone = data.aws_availability_zones.aws_availability_zones.names[0]
    map_public_ip_on_launch = false

    tags = {
      Name = "private_app_subnet_1"
    }
}

resource "aws_subnet" "private_app_subnet_2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_app_subnet_2_cidr
    availability_zone = data.aws_availability_zones.aws_availability_zones.names[1]
    map_public_ip_on_launch = false

    tags = {
      Name = "private_app_subnet_2"
    }
}

resource "aws_subnet" "private_data_subnet_1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_data_subnet_1_cidr
    availability_zone = data.aws_availability_zones.aws_availability_zones.names[0]
    map_public_ip_on_launch = false

    tags = {
      Name = "private_data_subnet_1"
    }
}

resource "aws_subnet" "private_data_subnet_2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_data_subnet_2_cidr
    availability_zone = data.aws_availability_zones.aws_availability_zones.names[1]
    map_public_ip_on_launch = false

    tags = {
      Name = "private_data_subnet_2"
    }
}

# resource "aws_route_table" "private_route_table" {
#     vpc_id = aws_vpc.vpc.id
#     route {
#         cidr_block = var.private_route_table_cidr
#         gateway_id = aws_internet_gateway.aws_internet_gateway.id
#     }

#     tags = {
#       Name = "private_route_table"
#     }
# }

# resource "aws_route_table_association" "private_subnet_1_route_table_assosication" {
#     subnet_id = aws_subnet.private_subnet_1.id
#     route_table_id = aws_route_table.private_route_table.id    
# }

# resource "aws_route_table_association" "private_subnet_2_route_table_assosication" {
#     subnet_id = aws_subnet.private_subnet_2.id
#     route_table_id = aws_route_table.private_route_table.id    
# }


