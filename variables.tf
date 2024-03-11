variable "vpc_configuration" {
  type = object({
    cidr_block = string
    instance_tenancy     = string
    enable_dns_hostnames = string
  })
}
#### Public Subnet #######

variable "subnet1_config" {
  type = object({
    cidr_block        = string
    availability_zone = string
    map_public_ip_on_launch = string
  })
}

variable "subnet2_config" {
  type = object({
    cidr_block        = string
    availability_zone = string
    map_public_ip_on_launch = string
  })
}

####### Public Route Table ##################

variable "public_route_table_config" {
  type = object({
    cidr_block = string
  })
}

############ Private Subnet ##############################

variable "pvt_subnet1_config" {
  type = object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = string
  })
}

variable "pvt_subnet2_config" {
  type = object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = string
  })
}


variable "pvt_subnet3_config" {
  type = object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = string
  })
}

variable "pvt_subnet4_config" {
  type = object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = string
  })
}

################# elastic IP ##############

variable "eip_natgateway1_config" {
  type = object({
    domain = string
  })
}

/*
variable "eip_natgateway2_config" {
  type = object({
    domain = string
  })
}
*/
####################### PRIVATE RTE TABLE 1 ###########

variable "private_route_table1_config" {
  type = object({
    cidr_block = string
  })
}

####################### PRIVATE RTE TABLE 2 ###########
/*
variable "private_route_table2_config" {
  type = object({
    cidr_block = string
  })
}*/


#################### ROUTE TABLE ASSOCIATION ######################

#################### SECURITY GORUPS #######################
/*
variable "alb-security-group_config" {
  type = object({
    name        = string
    description = string

    ingress_description = string
    ingress_from_port   = string
    ingress_to_port     = string
    ingress_protocol    = string
    ingress_cidr_blocks         = list(string)

    ingress2_description = string
    ingress2_from_port   = string
    ingress2_to_port     = string
    ingress2_protocol    = string
    ingress2_cidr_blocks         = list(string)


    egress_from_port   = string
    egress_to_port     = string
    egress_protocol    = string
    egress_cidr_blocks = list(string)


  })
}
*/
variable "ssh-security-group_config" {
  type = object({
    name        = string
    description = string

    ingress_description = string
    ingress_from_port   = string
    ingress_to_port     = string
    ingress_protocol    = string
    ingress_cidr_blocks = list(string)

    ingress2_description = string
    ingress2_from_port   = string
    ingress2_to_port     = string
    ingress2_protocol    = string
    ingress2_cidr_blocks = list(string)

    egress_from_port   = string
    egress_to_port     = string
    egress_protocol    = string
    egress_cidr_blocks = list(string)


  })
}
/*
variable "webserver-security-group_config" {
  type = object({
    name        = string
    description = string

    ingress_description = string
    ingress_from_port   = string
    ingress_to_port     = string
    ingress_protocol    = string

    ingress2_description = string
    ingress2_from_port   = string
    ingress2_to_port     = string
    ingress2_protocol    = string

    ingress3_description = string
    ingress3_from_port   = string
    ingress3_to_port     = string
    ingress3_protocol    = string

    egress_from_port   = string
    egress_to_port     = string
    egress_protocol    = string
    egress_cidr_blocks = list(string)


  })
}

variable "database-security-group_config" {
  type = object({
    name        = string
    description = string

    ingress_description = string
    ingress_from_port   = string
    ingress_to_port     = string
    ingress_protocol    = string

    egress_from_port   = string
    egress_to_port     = string
    egress_protocol    = string
    egress_cidr_blocks = list(string)


  })
}
*/


######### RDS ET SG RDS#############################

variable "wp_instance_config" {
  type = object({
    ami                         = string
    instance_type               = string
    key_name                    = string
    associate_public_ip_address = string
  })
}

variable "rds_instance_config" {
  type = object({
    engine                    = string
    engine_version            = string
    skip_final_snapshot       = string
    final_snapshot_identifier = string
    instance_class            = string
    allocated_storage         = number
    identifier                = string
    db_name                   = string
    username                  = string
    password                  = string
  })

}

variable "rds-security-group_config" {
  type = object({
    name                = string
    description         = string
    ingress_from_port   = string
    ingress_to_port     = string
    ingress_protocol    = string
    ingress_cidr_blocks = list(string)

  })
}
