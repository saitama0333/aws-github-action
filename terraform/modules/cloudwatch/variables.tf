variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "retention_in_days" {
  description = "Number of days to retain ECS application logs."
  type        = number
  default     = 1
}