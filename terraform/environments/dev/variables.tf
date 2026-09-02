variable "aws_region" {
  description = "AWS region where infrastructure will be deployed."
  type        = string
}

variable "project_name" {
  description = "Project name used for resource naming and tagging."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
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

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets. Must match availability_zones length."
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) == length(var.availability_zones)
    error_message = "public_subnet_cidrs must have the same number of entries as availability_zones."
  }
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets. Must match availability_zones length."
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_cidrs) == length(var.availability_zones)
    error_message = "private_subnet_cidrs must have the same number of entries as availability_zones."
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