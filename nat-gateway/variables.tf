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


######### PRIVATE RTE TABLE 1 ################################


variable "private_route_table1_config" {
  type = object({
    cidr_block = string
  })
} 


############ OUTPUT A DECLARER EN ATTIRBUT ####################
variable "public-subnet-1_id" {
  type = string
}

variable "public-subnet-2_id" {
  type = string
}

variable "internet_gateway" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private-subnet-1_id" {
  type = string
}

variable "private-subnet-3_id" {
  type = string
}

#################### AUTRE OUTPUT  AUTRE AVAILABILITY ZONE###########################


variable "private_route_table2_config" {
  type = object({
    cidr_block = string
  })
} 

variable "private-subnet-2_id" {
  type = string
}

variable "private-subnet-4_id" {
  type = string
}