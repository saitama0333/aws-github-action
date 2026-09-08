output "vpc_id" {
  value = aws_vpc.this.id
}

output "vpc_cidr" {
  value = var.vpc_cidr
}

output "public_subnet_ids" {
  value = {
    for name, subnet in aws_subnet.public :
    name => subnet.id
  }
}

output "private_subnet_ids" {
  value = {
    for name, subnet in aws_subnet.private :
    name => subnet.id
  }
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "private_route_table_ids" {
  value = {
    for az, route_table in aws_route_table.private :
    az => route_table.id
  }
}

output "nat_gateway_id" {
  value = aws_nat_gateway.this.id
}

output "availability_zones" {
  value = var.availability_zones
}