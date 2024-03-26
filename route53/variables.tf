# Route 53 Variables
variable "site_domain_config" {
  type = object({
    name                   = string
    sd_type                = string
    evaluate_target_health = string
  })
}

variable "domain_name" {
  type = string
}

variable "application_load_balancer_dns_name" {
  type = string
}

variable "application_load_balancer_zone_id" {
  type = string
}
