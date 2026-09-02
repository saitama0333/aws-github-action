locals {
  interface_endpoints = {
    ecr_api = {
      service_name = "com.amazonaws.${var.aws_region}.ecr.api"
    }

    ecr_dkr = {
      service_name = "com.amazonaws.${var.aws_region}.ecr.dkr"
    }

    logs = {
      service_name = "com.amazonaws.${var.aws_region}.logs"
    }
  }
}


resource "aws_security_group" "endpoints" {
  name        = "${var.project_name}-${var.environment}-vpc-endpoints"
  description = "Security group for VPC interface endpoints."
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS from VPC"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = [data.aws_vpc.this.cidr_block]
  }

  egress {
    description = "Allow HTTPS to VPC CIDR"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = [data.aws_vpc.this.cidr_block]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-vpc-endpoints"
  }
}

data "aws_vpc" "this" {
  id = var.vpc_id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = values(var.route_table_ids)

  tags = {
    Name = "${var.project_name}-${var.environment}-s3-endpoint"
  }
}

resource "aws_vpc_endpoint" "interface" {
  for_each = local.interface_endpoints

  vpc_id              = var.vpc_id
  service_name        = each.value.service_name
  vpc_endpoint_type   = "Interface"
  subnet_ids          = values(var.private_subnet_ids)
  security_group_ids  = [aws_security_group.endpoints.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.project_name}-${var.environment}-${each.key}-endpoint"
  }
}