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

############# OUTPUT A METTRE DEPUIS LE PROVIDER.TF##################
variable "subnet1_id" {
  type = string
}

variable "private_subnet1_id" {
  type = string
}

variable "private_subnet2_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "vpc_id" {
  type = string
}
