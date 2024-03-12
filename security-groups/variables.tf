variable "alb-security-group_config" {
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

variable "bastion-security-group_config" {
  type = object({
    name        = string
    description = string

    ingress_description = string
    ingress_from_port   = string
    ingress_to_port     = string
    ingress_protocol    = string
    ingress_cidr_blocks = list(string)

    egress_from_port   = string
    egress_to_port     = string
    egress_protocol    = string
    egress_cidr_blocks = list(string)


  })
}


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

    ingress2_description = string
    ingress2_from_port   = string
    ingress2_to_port     = string
    ingress2_protocol    = string

    egress_from_port   = string
    egress_to_port     = string
    egress_protocol    = string
    egress_cidr_blocks = list(string)


  })
}


variable "vpc_id" {
  type = string
}

