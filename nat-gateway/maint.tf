resource "aws_eip" "eip-for-nat-gateway-1" {
  domain = var.eip_natgateway1_config.domain

  tags = {
    Name = "EIP 1"
  }

}

resource "aws_eip" "eip-for-nat-gateway-2" {
  domain = var.eip_natgateway2_config.domain

  tags = {
    Name = "EIP 2"
  }

}

resource "aws_nat_gateway" "nat-gateway-1" {
  depends_on    = [var.internet_gateway]
  allocation_id = aws_eip.eip-for-nat-gateway-1.id
  subnet_id     = var.public-subnet-1_id

  tags = {
    Name = "Terra Nat Gateway Public Subnet 1"
  }
}


resource "aws_nat_gateway" "nat-gateway-2" {
  depends_on    = [var.internet_gateway]
  allocation_id = aws_eip.eip-for-nat-gateway-2.id
  subnet_id     = var.public-subnet-2_id

  tags = {
    Name = "Nat Gateway Public Subnet 2"
  }
}


resource "aws_route_table" "private-route-table-1" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = var.private_route_table1_config.cidr_block
    nat_gateway_id = aws_nat_gateway.nat-gateway-1.id
  }

  tags = {
    Name = "Terra Private Route Table 1"
  }
}

resource "aws_route_table_association" "private-subnet-1-route-table-association" {
  subnet_id      = var.private-subnet-1_id
  route_table_id = aws_route_table.private-route-table-1.id
}

resource "aws_route_table_association" "private-subnet-3-route-table-association" {
  subnet_id      = var.private-subnet-3_id
  route_table_id = aws_route_table.private-route-table-1.id
}

############ AUTRE AVAILABILITY ZONE ##################

resource "aws_route_table" "private-route-table-2" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = var.private_route_table2_config.cidr_block
    nat_gateway_id = aws_nat_gateway.nat-gateway-2.id
  }

  tags = {
    Name = "Terra Private Route Table 2"
  }
}

resource "aws_route_table_association" "private-subnet-2-route-table-association" {
  subnet_id      = var.private-subnet-2_id
  route_table_id = aws_route_table.private-route-table-2.id
}

resource "aws_route_table_association" "private-subnet-4-route-table-association" {
  subnet_id      = var.private-subnet-4_id
  route_table_id = aws_route_table.private-route-table-2.id
}
