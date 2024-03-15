# export the acm certificate arn
output "certificate_arn" {
  value = aws_acm_certificate.acm_certificate.arn
}

# export the domain name
output "domain_name" {
  value = var.acm_certificate_config.domain_name
}