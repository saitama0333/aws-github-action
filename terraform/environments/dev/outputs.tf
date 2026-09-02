output "vpc_id" {
  description = "ID of the VPC."
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC."
  value       = module.vpc.vpc_cidr
}

output "public_subnet_ids" {
  description = "IDs of the public subnets keyed by Availability Zone."
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets keyed by Availability Zone."
  value       = module.vpc.private_subnet_ids
}

output "availability_zones" {
  description = "Availability Zones used by the VPC."
  value       = module.vpc.availability_zones
}

output "ecr_repository_name" {
  description = "Name of the ECR repository."
  value       = module.ecr.repository_name
}

output "ecr_repository_url" {
  description = "URL of the ECR repository."
  value       = module.ecr.repository_url
}

output "ecr_repository_arn" {
  description = "ARN of the ECR repository."
  value       = module.ecr.repository_arn
}

output "github_actions_role_arn" {
  description = "ARN of the IAM role assumed by GitHub Actions."
  value       = module.iam.github_actions_role_arn
}

output "github_oidc_provider_arn" {
  description = "ARN of the GitHub OIDC provider."
  value       = module.iam.github_oidc_provider_arn
}