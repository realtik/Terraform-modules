# create security group for the application load balancer
resource "aws_security_group" "alb-security_group" {
  name        = var.alb-security-group_config.name
  description = var.alb-security-group_config.description
  vpc_id      = var.vpc_id

  ingress {
    description = var.alb-security-group_config.ingress_description
    from_port   = var.alb-security-group_config.ingress_from_port
    to_port     = var.alb-security-group_config.ingress_to_port
    protocol    = var.alb-security-group_config.ingress_protocol
    cidr_blocks = var.alb-security-group_config.ingress_cidr_blocks
  }

  ingress {
    description = var.alb-security-group_config.ingress2_description
    from_port   = var.alb-security-group_config.ingress2_from_port
    to_port     = var.alb-security-group_config.ingress2_to_port
    protocol    = var.alb-security-group_config.ingress2_protocol
    cidr_blocks = var.alb-security-group_config.ingress2_cidr_blocks
  }

  egress {
    from_port   = var.alb-security-group_config.egress_from_port
    to_port     = var.alb-security-group_config.egress_to_port
    protocol    = var.alb-security-group_config.egress_protocol
    cidr_blocks = var.alb-security-group_config.egress_cidr_blocks
  }

  tags = {
    Name = "Terra ALB Security Group"
  }
}

# create security group for the bastion host aka jump box
resource "aws_security_group" "bastion-security_group" {
  name        = var.bastion-security-group_config.name
  description = var.bastion-security-group_config.description
  vpc_id      = var.vpc_id

  ingress {
    description = var.bastion-security-group_config.ingress_description
    from_port   = var.bastion-security-group_config.ingress_from_port
    to_port     = var.bastion-security-group_config.ingress_to_port
    protocol    = var.bastion-security-group_config.ingress_protocol
    cidr_blocks = var.bastion-security-group_config.ingress_cidr_blocks
  }

  egress {
    from_port   = var.bastion-security-group_config.egress_from_port
    to_port     = var.bastion-security-group_config.egress_to_port
    protocol    = var.bastion-security-group_config.egress_protocol
    cidr_blocks = var.bastion-security-group_config.egress_cidr_blocks
  }

  tags = {
    Name = "Terra Bastion-Jump Box Security Group"
  }
}

# create security group for the app server
resource "aws_security_group" "webserver-security-group" {
  name        = var.webserver-security-group_config.name
  description = var.webserver-security-group_config.description
  vpc_id      = var.vpc_id

  ingress {
    description      = var.webserver-security-group_config.ingress_description
    from_port        = var.webserver-security-group_config.ingress_from_port
    to_port          = var.webserver-security-group_config.ingress_to_port
    protocol         = var.webserver-security-group_config.ingress_protocol
    security_groups  = [aws_security_group.alb-security-group.id]
  }

  ingress {
    description      = var.webserver-security-group_config.ingress2_description
    from_port        = var.webserver-security-group_config.ingress2_from_port
    to_port          = var.webserver-security-group_config.ingress2_to_port
    protocol         = var.webserver-security-group_config.ingress2_protocol
    security_groups  = [aws_security_group.alb-security-group.id]
  }

  egress {
    from_port        = var.webserver-security-group_config.egress_from_port
    to_port          = var.webserver-security-group_config.egress_to_port
    protocol         = var.webserver-security-group_config.egress_protocol
    cidr_blocks      = var.webserver-security-group_config.egress_cidr_blocks
  }

  tags   = {
    Name = "Terra Web Server Security Group"
  }
}


# Create Security Group for the Database
# terraform aws create security group
resource "aws_security_group" "database-security-group" {
  name        = var.database-security-group_config.name
  description = var.database-security-group_config.description
  vpc_id      = var.vpc_id

  ingress {
    description      = var.database-security-group_config.ingress_description
    from_port        = var.database-security-group_config.ingress_from_port
    to_port          = var.database-security-group_config.ingress_to_port
    protocol         = var.database-security-group_config.ingress_protocol
    security_groups  = [aws_security_group.webserver-security-group.id]
  }

ingress {
    description      = var.database-security-group_config.ingress2_description
    from_port        = var.database-security-group_config.ingress2_from_port
    to_port          = var.database-security-group_config.ingress2_to_port
    protocol         = var.database-security-group_config.ingress2_protocol
    security_groups  = [aws_security_group.bastion_security_group.id]
  }

  egress {
    from_port        = var.database-security-group_config.egress_from_port
    to_port          = var.database-security-group_config.egress_to_port
    protocol         = var.database-security-group_config.egress_protocol
    cidr_blocks      = var.database-security-group_config.egress_cidr_blocks
  }

  tags   = {
    Name = "Terra Database Security Group"
  }
}
