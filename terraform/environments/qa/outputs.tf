output "alb_dns_name" {
  description = "DNS name of the QA application load balancer."
  value       = module.alb.load_balancer_dns_name
}

output "ecr_repository_url" {
  description = "QA ECR repository URL."
  value       = module.ecr.repository_url
}

output "ecs_cluster_name" {
  description = "QA ECS cluster name."
  value       = module.ecs.cluster_name
}

output "ecs_service_name" {
  description = "QA ECS service name."
  value       = module.ecs.service_name
}

output "ecs_task_definition_arn" {
  description = "QA ECS task definition ARN."
  value       = module.ecs.task_definition_arn
}

output "github_actions_role_arn" {
  description = "QA GitHub Actions IAM role ARN."
  value       = module.iam.github_actions_role_arn
}

output "github_oidc_provider_arn" {
  description = "GitHub OIDC provider ARN."
  value       = module.iam.github_oidc_provider_arn
}

output "vpc_id" {
  description = "QA VPC ID."
  value       = module.vpc.vpc_id
}