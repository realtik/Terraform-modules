variable "acm_certificate_config" {
  type = object({
    domain_name               = string
    subject_alternative_names = string
    validation_method         = string
  })
}

variable "route53_zone_config" {
  type = object({
    private_zone = string
  })
}

