
/*#rds subnet
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [var.private-subnet-3_id, var.private-subnet-4_id]
}
#RDS INSTANCE
resource "aws_db_instance" "rds_instance" {
  engine                    = var.rds_instance_config.engine
  availability_zone         = var.rds_instance_config.availability_zone
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
  multi_az                  = var.rds_instance_config.multi_az
  vpc_security_group_ids    = [var.database_security_group_id]

  tags = {
    Name = "RDS Instance"
  }
}
*/


# create database subnet group
resource "aws_db_subnet_group" "database_subnet_group" {
  name        = "rds-subnet-group"
  subnet_ids  = [var.private-subnet-3_id, var.private-subnet-4_id]
  description = "subnets for database instance"

  tags = {
    Name = "database subnet"
  }
}

# get information about a database snapshot
data "aws_db_snapshot" "latest_db_snapshot" {
  db_snapshot_identifier = var.snapshot_config.db_snapshot_identifier
  most_recent            = true
  snapshot_type          = var.snapshot_config.snapshot_type
}

# launch an rds instance from a database snapshot
resource "aws_db_instance" "database_instance" {
  instance_class         = var.rds_instance_config.instance_class
  skip_final_snapshot    = true
  availability_zone      = var.rds_instance_config.availability_zone
  identifier             = var.rds_instance_config.identifier
  snapshot_identifier    = data.aws_db_snapshot.latest_db_snapshot.id
  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
  multi_az               = var.rds_instance_config.multi_az
  vpc_security_group_ids = [var.database_security_group_id]
}