output "github_actions_role_arn" {
  description = "ARN of the IAM role assumed by GitHub Actions."
  value       = aws_iam_role.github_actions.arn
}

output "github_actions_role_name" {
  description = "Name of the IAM role assumed by GitHub Actions."
  value       = aws_iam_role.github_actions.name
}

output "github_oidc_provider_arn" {
  description = "ARN of the GitHub OIDC provider."
  value       = aws_iam_openid_connect_provider.github.arn
}

output "ecs_task_execution_role_arn" {
  description = "ARN of the ECS task execution IAM role."
  value       = aws_iam_role.ecs_task_execution.arn
}

output "ecs_task_role_arn" {
  description = "ARN of the ECS application task IAM role."
  value       = aws_iam_role.ecs_task.arn
}

output "ecs_task_execution_policy_id" {
  description = "ID of the ECS task execution role inline policy."
  value       = aws_iam_role_policy.ecs_task_execution.id
}
