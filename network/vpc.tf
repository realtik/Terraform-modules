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

################ ELASTIC IP #################

resource "aws_eip" "eip-for-nat-gateway-1" {
  domain = var.eip_natgateway1_config.domain 

  tags   = {
    Name = "EIP 1"
  }

}

/*resource "aws_eip" "eip-for-nat-gateway-2" {
  domain = var.eip_natgateway2_config.domain 

  tags   = {
    Name = "EIP 2"
  }

}*/

################# NAT GATEWAY #########################

resource "aws_nat_gateway" "nat-gateway-1" {
  allocation_id = aws_eip.eip-for-nat-gateway-1.id
  subnet_id     = aws_subnet.public-subnet-1.id

  tags   = {
    Name = "Terra Nat Gateway Public Subnet 1"
  }
}

/*
resource "aws_nat_gateway" "nat-gateway-2" {
  allocation_id = aws_eip.eip-for-nat-gateway-2.id
  subnet_id     = aws_subnet.public-subnet-2.id

  tags   = {
    Name = "Nat Gateway Public Subnet 2"
  }
}*/

################ PRIVATE ROUTE TABLE 1 #######################

resource "aws_route_table" "private-route-table-1" {
  vpc_id            = aws_vpc.vpc.id

  route {
    cidr_block      = var.private_route_table1_config.cidr_block
    nat_gateway_id  = aws_nat_gateway.nat-gateway-1.id
  }

  tags   = {
    Name = "Terra Private Route Table 1"
  }
}

################ PRIVATE ROUTE TABLE 2 #######################
/*
resource "aws_route_table" "private-route-table-2" {
  vpc_id            = aws_vpc.vpc.id

  route {
    cidr_block      = var.private_route_table2_config.cidr_block
    nat_gateway_id  = aws_nat_gateway.nat-gateway-2.id
  }

  tags   = {
    Name = "Private Route Table 2"
  }
}
*/

#################### ROUTE TABLE ASSOCIATION ######################

resource "aws_route_table_association" "private-subnet-1-route-table-association" {
  subnet_id = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-route-table-1.id
}
/*
resource "aws_route_table_association" "private-subnet-3-route-table-association" {
  subnet_id = aws_subnet.private-subnet-3.id
  route_table_id = aws_route_table.private-route-table-1.id
}*/

resource "aws_route_table_association" "private-subnet-2-route-table-association" {
  subnet_id = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-route-table-1.id
}
/*
resource "aws_route_table_association" "private-subnet-4-route-table-association" {
  subnet_id = aws_subnet.private-subnet-4.id
  route_table_id = aws_route_table.private-route-table-2.id
}*/

/*
resource "aws_subnet" "public-subnet" {
  for_each = { for sub in var.subnet_config : sub.name => sub }

  vpc_id = aws_vpc.vpc.id
  cidr_block = var.subnet_config.cidr_block
  availability_zone = var.subnet_config.availability_zone
  map_public_ip_on_launch = var.subnet_config.map_public_ip_on_launch
}
*/
