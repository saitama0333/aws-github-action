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