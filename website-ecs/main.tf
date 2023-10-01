provider "aws" {
  region = var.region
  profile = "sam"
}

#create vpc
module "vpc" {
  source = "../modules/vpc"
  region = var.region
  vpc_cidr = var.vpc_cidr
  project_name = var.project_name
  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr
  
  private_app_subnet_1_cidr = var.private_app_subnet_1_cidr
  private_app_subnet_2_cidr = var.private_app_subnet_2_cidr

  private_data_subnet_1_cidr = var.private_data_subnet_1_cidr
  private_data_subnet_2_cidr = var.private_data_subnet_2_cidr
}

module "nat_gateway" {
  source = "../modules/nat-gateway"
  public_subnet_1 = module.vpc.public_subnet_1
  public_subnet_2 = module.vpc.public_subnet_2
  internet_gateway = module.vpc.internet_gateway
  vpc_id= module.vpc.vpc_id
  private_app_subnet_1= module.vpc.private_app_subnet_1
  private_data_subnet_1= module.vpc.private_data_subnet_1
  private_app_subnet_2= module.vpc.private_app_subnet_2
  private_data_subnet_2= module.vpc.private_data_subnet_2
}

module "security_group" {
  source = "../modules/security-groups"
  vpc_id = module.vpc.vpc_id
}

module "ecs_tasks_execution_role" {
  source = "../modules/ecs-tasks-execution-role"
  project_name = module.vpc.project_name
}
module "acm" {
  source = "../modules/acm"
  domain_name = var.domain_name
  alternative_name = var.alternative_name
}

# module "application_load_balancer" {
#     source = "../modules/load-balancer"
#     project_name = module.vpc.project_name    
#     alb_security_group = module.security_group.alb_security_group_id
#     # alb_target_group = 
#     public_subnet_1 = module.vpc.public_subnet_1
#     public_subnet_2 = module.vpc.public_subnet_2
#     vpc_id = module.vpc.vpc_id
#     certificate_arn = module.acm.certificate_arn
# }