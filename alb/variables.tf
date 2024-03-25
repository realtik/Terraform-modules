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
    port                = number
    protocol            = string
    healthy_threshold   = number
    interval            = number
    matcher             = string
    path                = string
    ht_port             = string
    ht_protocol         = string
    timeout             = number
    unhealthy_threshold = number
  })
}

variable "alb_http_listener_config" {
  type = object({
    port              = number
    protocol          = string
    type              = string
    redirect_port     = number
    redirect_protocol = string
    status_code       = string
  })
}

variable "alb_https_listener_config" {
  type = object({
    port              = number
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