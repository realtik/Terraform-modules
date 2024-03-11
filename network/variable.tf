variable "vpc_configuration" {
  type = object({
    cidr_block           = string
    instance_tenancy     = string
    enable_dns_hostnames = string
  })
}

#### Public Subnet #######

variable "subnet1_config" {
  type = object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = string
  })
}

variable "subnet2_config" {
  type = object({
    cidr_block              = string
    availability_zone       = string
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
/*
################# elastic IP ##############
variable "eip_natgateway1_config" {
  type = object({
    domain = string
  })
}

variable "eip_natgateway2_config" {
  type = object({
    domain = string
  })
}

####################### PRIVATE RTE TABLE 1 ###########

variable "private_route_table1_config" {
  type = object({
    cidr_block = string
  })
} 

####################### PRIVATE RTE TABLE 2 ###########

variable "private_route_table2_config" {
  type = object({
    cidr_block = string
  })
} 
*/
#################### ROUTE TABLE ASSOCIATION ######################