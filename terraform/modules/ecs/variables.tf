variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "aws_region" {
  description = "AWS region where ECS resources are deployed."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where ECS resources are deployed."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs where ECS tasks will run."
  type        = map(string)
}

variable "container_image" {
  description = "Container image URI used by the ECS task definition."
  type        = string
}

variable "container_port" {
  description = "Port exposed by the application container."
  type        = number
  default     = 8080
}

variable "cpu" {
  description = "Fargate task CPU units."
  type        = number
  default     = 256
}

variable "memory" {
  description = "Fargate task memory in MiB."
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Desired number of ECS service tasks."
  type        = number
  default     = 2
}

variable "app_environment" {
  description = "Environment variables passed to the application container."
  type        = map(string)
  default     = {}
}

variable "execution_role_arn" {
  description = "ARN of the ECS task execution IAM role."
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the ECS task IAM role."
  type        = string
}

variable "log_group_name" {
  description = "CloudWatch Logs group name for ECS container logs."
  type        = string
}