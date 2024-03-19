variable "alb_config" {
  type = object({
    name                       = string
    internal                   = string
    load_balancer_type         = string
    enable_deletion_protection = string
  })
}

variable "alb_target_group_config" {
  type = object({
    name                = string
    target_type         = string
    port                = string
    protocol            = string
    healthy_threshold   = string
    interval            = string
    matcher             = string
    path                = string
    ht_port             = string
    ht_protocol         = string
    timeout             = string
    unhealthy_threshold = string
  })
}

variable "alb_http_listener_config" {
  type = object({
    port              = string
    protocol          = string
    type              = string
    redirect_port     = string
    redirect_protocol = string
    status_code       = string
  })
}

variable "alb_https_listener_config" {
  type = object({
    port              = string
    protocol          = string
    ssl_policy        = string
    type              = string
  })
}

#################### VARIABLE OUTPUT ####################

variable "alb_security_group_id" {
  type = string
}

variable "public-subnet-1_id" {
  type = string
}

variable "public-subnet-2_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "certificate_arn" {
  type = string
}