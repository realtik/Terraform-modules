output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "internet-gateway_id" {
  value = aws_internet_gateway.internet-gateway.id
}

################ PUBLIC SUBNET ID ############################

output "public-subnet-1_id" {
  value = aws_subnet.public-subnet-1.id
}

output "public-subnet-2_id" {
  value = aws_subnet.public-subnet-2.id
}

##################### PUBLIC ROUTE TABLE ID ######################

output "public-route-table_id" {
  value = aws_route_table.public-route-table.id
}

############# PRIVATE SUBNET ID #####################################

output "private-subnet-1_id" {
  value = aws_subnet.private-subnet-1.id
}

output "private-subnet-2_id" {
  value = aws_subnet.private-subnet-2.id
}

output "private-subnet-3_id" {
  value = aws_subnet.private-subnet-3.id
}

output "private-subnet-4_id" {
  value = aws_subnet.private-subnet-4.id
}
