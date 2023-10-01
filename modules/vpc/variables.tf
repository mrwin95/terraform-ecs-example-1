variable "region" {}

variable "project_name" {}

variable "vpc_cidr" {}

variable "public_subnet_1_cidr" {}

variable "public_subnet_2_cidr" {}

variable "public_route_table_cidr" {
  type = string
  default = "0.0.0.0/0"
}

variable "private_app_subnet_1_cidr" {}

variable "private_app_subnet_2_cidr" {}


variable "private_data_subnet_1_cidr" {}

variable "private_data_subnet_2_cidr" {}

