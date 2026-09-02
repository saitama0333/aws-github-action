variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ALB is deployed."
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR."
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs where the ALB will be deployed."
  type        = map(string)
}

variable "target_port" {
  description = "Port exposed by ECS tasks."
  type        = number
  default     = 8080
}

variable "health_check_path" {
  description = "HTTP health check path."
  type        = string
  default     = "/health"
}

variable "enable_deletion_protection" {
  description = "Enable ALB deletion protection."
  type        = bool
  default     = false
}