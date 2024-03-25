/*variable "rds_instance_config" {
  type = object({
    engine                    = string
    availability_zone         = string
    engine_version            = string
    skip_final_snapshot       = string
    final_snapshot_identifier = string
    instance_class            = string
    allocated_storage         = number
    identifier                = string
    db_name                   = string
    username                  = string
    password                  = string
    multi_az                  = string
  })

}
*/

variable "snapshot_config" {
  type = object({
    db_snapshot_identifier = string
    snapshot_type = string
  })
}

variable "rds_instance_config" {
  type = object({
    instance_class            = string
    availability_zone         = string
    identifier                = string
    multi_az                  = string
  })
}
variable "database_security_group_id" {
    type = string
}

variable "private-subnet-3_id" {
  type = string
}

variable "private-subnet-4_id" {
  type = string
}
