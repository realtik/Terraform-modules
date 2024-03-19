# create application load balancer
resource "aws_lb" "application_load_balancer" {
  name                       = var.alb_config.name
  internal                   = var.alb_config.internal
  load_balancer_type         = var.alb_config.load_balancer_type
  security_groups            = [var.alb_security_group_id]
  subnets                    = [var.public-subnet-1_id, var.public-subnet-2_id]
  enable_deletion_protection = var.alb_config.enable_deletion_protection

  tags = {
    Name = "alb terraform ECS"
  }
}

# create target group
resource "aws_lb_target_group" "alb_target_group" {
  name        = var.alb_target_group_config.name
  target_type = var.alb_target_group_config.target_type
  port        = var.alb_target_group_config.port
  protocol    = var.alb_target_group_config.protocol
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = var.alb_target_group_config.healthy_threshold
    interval            = var.alb_target_group_config.interval
    matcher             = var.alb_target_group_config.matcher
    path                = var.alb_target_group_config.path
    port                = var.alb_target_group_config.ht_port
    protocol            = var.alb_target_group_config.ht_protocol
    timeout             = var.alb_target_group_config.timeout
    unhealthy_threshold = var.alb_target_group_config.unhealthy_threshold
  }
}

# create a listener on port 80 with redirect action
resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = var.alb_http_listener_config.port
  protocol          = var.alb_http_listener_config.protocol

  default_action {
    type = var.alb_http_listener_config.type

    redirect {
      port        = var.alb_http_listener_config.redirect_port
      protocol    = var.alb_http_listener_config.redirect_protocol
      status_code = var.alb_http_listener_config.status_code
    }
  }
}

# create a listener on port 443 with forward action
resource "aws_lb_listener" "alb_https_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = var.alb_https_listener_config.port
  protocol          = var.alb_https_listener_config.protocol
  ssl_policy        = var.alb_https_listener_config.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = var.alb_https_listener_config.type
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}
