variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "github_repository" {
  description = "GitHub repository in owner/repository format."
  type        = string
}

variable "github_branch" {
  description = "GitHub branch allowed to assume the deployment role."
  type        = string
}

variable "ecr_repository_arn" {
  description = "ARN of the ECR repository GitHub Actions can push to."
  type        = string
}

variable "ecs_task_execution_role_name" {
  description = "Name of the ECS task execution IAM role."
  type        = string
}

variable "ecs_task_role_name" {
  description = "Name of the ECS application task IAM role."
  type        = string
}

variable "log_group_arn" {
  description = "ARN of the CloudWatch Logs group used by ECS tasks."
  type        = string
}

variable "ecs_service_arn" {
  description = "ARN of the ECS service GitHub Actions can deploy."
  type        = string
}
