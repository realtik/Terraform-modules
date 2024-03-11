resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_configuration.cidr_block
  instance_tenancy = var.vpc_configuration.instance_tenancy
  enable_dns_hostnames = var.vpc_configuration.enable_dns_hostnames
  tags = {
    Name = "Terraform ECS VPC"
  }
}

resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Terraform WP IGW"
  }
}


#### Public Subnet #######

resource "aws_subnet" "public-subnet-1" {
  
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.subnet1_config.cidr_block
  availability_zone = var.subnet1_config.availability_zone
  map_public_ip_on_launch = var.subnet1_config.map_public_ip_on_launch

  tags = {
    Name = "Terra Public Subnet 1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.subnet2_config.cidr_block
  availability_zone = var.subnet2_config.availability_zone
  map_public_ip_on_launch = var.subnet2_config.map_public_ip_on_launch

  tags = {
    Name = "Terra Public Subnet 2"
  }
}


####### Public Route Table ##################

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id
  
  route {
    cidr_block = var.public_route_table_config.cidr_block
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags = {
    Name = "Terra Public Route Table"
  }
}

resource "aws_route_table_association" "public-subnet-1-aws_route_table_association" {
  subnet_id = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-subnet-2-aws_route_table_association" {
  subnet_id = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-route-table.id
}


############ Private Subnet ##############################

resource "aws_subnet" "private-subnet-1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.pvt_subnet1_config.cidr_block
  availability_zone = var.pvt_subnet1_config.availability_zone
  map_public_ip_on_launch = var.pvt_subnet1_config.map_public_ip_on_launch

  tags = {
    Name = "Terra Private Subnet 1 | App Tier"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.pvt_subnet2_config.cidr_block
  availability_zone = var.pvt_subnet2_config.availability_zone
  map_public_ip_on_launch = var.pvt_subnet2_config.map_public_ip_on_launch

  tags = {
    Name = "terra Private Subnet 2 | App Tier"
  }
}

resource "aws_subnet" "private-subnet-3" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.pvt_subnet3_config.cidr_block
  availability_zone = var.pvt_subnet3_config.availability_zone
  map_public_ip_on_launch = var.pvt_subnet3_config.map_public_ip_on_launch

  tags = {
    Name = "Terra Private Subnet 3 | Database Tier"
  }
}

resource "aws_subnet" "private-subnet-4" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.pvt_subnet4_config.cidr_block
  availability_zone = var.pvt_subnet4_config.availability_zone
  map_public_ip_on_launch = var.pvt_subnet4_config.map_public_ip_on_launch

  tags = {
    Name = "Terra Private Subnet 4 | Database Tier"
  }
}
