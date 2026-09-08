resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-${var.environment}-vpc"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-${var.environment}-igw"
  }
}

resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-${each.key}"
    Tier = "public"
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.project_name}-${var.environment}-${each.key}"
    Tier = "private"
  }
}

# One public route table shared by all public subnets.

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-${var.environment}-public-rt"
  }
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# One NAT Gateway for the current Dev cost-optimized setup.
# The subnet is selected through configuration rather than hardcoded AZ[0].

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-${var.environment}-nat-eip"
  }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[var.nat_subnet_name].id

  depends_on = [
    aws_internet_gateway.this
  ]

  tags = {
    Name = "${var.project_name}-${var.environment}-nat"
  }
}

# One private route table per AZ.

resource "aws_route_table" "private" {
  for_each = toset(var.availability_zones)

  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-${var.environment}-private-rt-${each.key}"
  }
}

resource "aws_route" "private_nat" {
  for_each = aws_route_table.private

  route_table_id         = each.value.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id
}

# Each private subnet uses the route table belonging to its AZ.

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id = each.value.id

  route_table_id = aws_route_table.private[
    each.value.availability_zone
  ].id
}