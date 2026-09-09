variable "aws_region" {
  description = "AWS region for the environment."
  type        = string
}

variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the environment VPC."
  type        = string
}

variable "availability_zones" {
  description = "Availability zones used by the environment."
  type        = list(string)
}

variable "public_subnets" {
  description = "Map of public subnet definitions."
  type = map(object({
    az   = string
    cidr = string
  }))
}

variable "private_subnets" {
  description = "Map of private subnet definitions."
  type = map(object({
    az   = string
    cidr = string
  }))
}

variable "nat_subnet_name" {
  description = "Name of the public subnet where the NAT Gateway is created."
  type        = string
}

variable "initial_image_tag" {
  description = "Existing ECR image tag used by Terraform when creating the initial ECS task definition."
  type        = string
}

variable "github_oidc_subject" {
  description = "Immutable GitHub OIDC subject allowed to assume the QA deployment role."
  type        = string
}

variable "github_repository" {
  description = "GitHub repository in owner/repository format."
  type        = string
}

variable "github_branch" {
  description = "GitHub branch associated with this environment."
  type        = string
}