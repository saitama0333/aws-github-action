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

variable "vpc_cidr" {
  description = "VPC CIDR used for ECS task egress."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs where ECS tasks will run."
  type        = map(string)
}

variable "container_image" {
  description = "Immutable container image reference used by the ECS task definition."
  type        = string
}

variable "container_name" {
  description = "Name of the application container."
  type        = string
  default     = "app"
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
  default     = 1
}

variable "app_version" {
  description = "Application version exposed to the container."
  type        = string
  default     = "unknown"
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
  description = "ARN of the ECS application task IAM role."
  type        = string
}

variable "log_group_name" {
  description = "CloudWatch Logs group name for ECS container logs."
  type        = string
}

variable "alb_security_group_id" {
  description = "Security group ID of the Application Load Balancer."
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the ALB target group used by the ECS service."
  type        = string
}

variable "execution_role_policy_dependency" {
  description = "Dependency ensuring the ECS execution-role policy exists before service creation."
  type        = any
}

variable "enable_container_insights" {
  description = "Enable ECS Container Insights for enhanced cluster and task observability."
  type        = bool
  default     = false
}