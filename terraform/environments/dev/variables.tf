variable "aws_region" {
  description = "AWS region where infrastructure will be deployed."
  type        = string
}

variable "project_name" {
  description = "Project name used for resource naming and tagging."
  type        = string
}

variable "environment" {
  type = string

  validation {
    condition     = contains(["dev", "qa", "prod"], var.environment)
    error_message = "Environment must be one of: dev, qa, prod."
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "availability_zones" {
  description = "Availability Zones used by the environment."
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "At least two Availability Zones are required."
  }
}

variable "public_subnets" {
  type = map(object({
    az   = string
    cidr = string
  }))

  validation {
    condition = alltrue([
      for subnet in values(var.public_subnets) :
      contains(var.availability_zones, subnet.az)
    ])

    error_message = "Every public subnet AZ must exist in availability_zones."
  }
}

variable "private_subnets" {
  type = map(object({
    az   = string
    cidr = string
  }))

  validation {
    condition = alltrue([
      for subnet in values(var.private_subnets) :
      contains(var.availability_zones, subnet.az)
    ])

    error_message = "Every private subnet AZ must exist in availability_zones."
  }
}

variable "nat_subnet_name" {
  type = string

  validation {
    condition     = contains(keys(var.public_subnets), var.nat_subnet_name)
    error_message = "nat_subnet_name must reference an existing public subnet."
  }
}

variable "github_repository" {
  description = "GitHub repository in owner/repository format."
  type        = string
}

variable "github_branch" {
  description = "GitHub branch allowed to deploy to AWS."
  type        = string
}

variable "initial_image_tag" {
  description = "Existing ECR image tag used by Terraform when creating the initial ECS task definition."
  type        = string
}
