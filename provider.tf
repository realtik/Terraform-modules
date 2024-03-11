provider "aws" {
  region  = "eu-west-3"
  profile = "terraform-user"
}

module "network" {
  source                      = "./network"
  vpc_configuration           = var.vpc_configuration
  subnet1_config              = var.subnet1_config
  subnet2_config              = var.subnet2_config
  public_route_table_config   = var.public_route_table_config
  pvt_subnet1_config          = var.pvt_subnet1_config
  pvt_subnet2_config          = var.pvt_subnet2_config
  #pvt_subnet3_config          = var.pvt_subnet3_config
  #pvt_subnet4_config          = var.pvt_subnet4_config
  eip_natgateway1_config      = var.eip_natgateway1_config
  #eip_natgateway2_config      = var.eip_natgateway2_config
  private_route_table1_config = var.private_route_table1_config
  #private_route_table2_config = var.private_route_table2_config
}

module "security_group" {
  source                      = "./security_group"
  vpc_id = module.network.vpc_id
  #alb-security-group_config = var.alb-security-group_config
  ssh-security-group_config = var.ssh-security-group_config
  #webserver-security-group_config = var.webserver-security-group_config
  #database-security-group_config = var.database-security-group_config
}

module "EC2" {
  source = "./EC2"
  wp_instance_config = var.wp_instance_config
  vpc_id = module.network.vpc_id
  security_group_id = module.security_group.allow_ssh_id
  subnet1_id = module.network.public-subnet-1_id
  private_subnet1_id = module.network.private-subnet-1_id
  private_subnet2_id = module.network.private-subnet-2_id
  rds-security-group_config = var.rds-security-group_config
  rds_instance_config = var.rds_instance_config
}