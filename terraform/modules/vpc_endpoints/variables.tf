variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where endpoints will be created."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs where interface endpoints will be created."
  type        = map(string)
}

variable "route_table_ids" {
  description = "Route table IDs associated with private subnets."
  type        = map(string)
}

variable "aws_region" {
  description = "AWS region where the VPC endpoints will be created."
  type        = string
}

variable "ecs_task_security_group_id" {
  description = "Security group ID of the ECS Fargate tasks."
  type        = string
}