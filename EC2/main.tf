#EC2
resource "aws_instance" "wordpress" {
  ami                         = var.wp_instance_config.ami
  instance_type               = var.wp_instance_config.instance_type
  key_name                    = var.wp_instance_config.key_name
  subnet_id                   = var.subnet1_id
  security_groups             = [var.security_group_id]
  associate_public_ip_address = var.wp_instance_config.associate_public_ip_address

}

#rds subnet
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [var.private_subnet1_id, var.private_subnet2_id]
}
#RDS INSTANCE
resource "aws_db_instance" "rds_instance" {
  engine                    = var.rds_instance_config.engine
  engine_version            = var.rds_instance_config.engine_version
  skip_final_snapshot       = var.rds_instance_config.skip_final_snapshot
  final_snapshot_identifier = var.rds_instance_config.final_snapshot_identifier
  instance_class            = var.rds_instance_config.instance_class
  allocated_storage         = var.rds_instance_config.allocated_storage
  identifier                = var.rds_instance_config.identifier
  db_name                   = var.rds_instance_config.db_name
  username                  = var.rds_instance_config.username
  password                  = var.rds_instance_config.password
  db_subnet_group_name      = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids    = [aws_security_group.rds_security_group.id]

  tags = {
    Name = "RDS Instance"
  }
}

# RDS security group
resource "aws_security_group" "rds_security_group" {
  name        = var.rds-security-group_config.name
  description = var.rds-security-group_config.description
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.rds-security-group_config.ingress_from_port
    to_port     = var.rds-security-group_config.ingress_to_port
    protocol    = var.rds-security-group_config.ingress_protocol
    cidr_blocks = var.rds-security-group_config.ingress_cidr_blocks
  }

  tags = {
    Name = "RDS Security Group"
  }
}
