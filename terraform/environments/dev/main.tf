module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr

  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "vpc_endpoints" {
  source = "../../modules/vpc_endpoints"

  aws_region   = var.aws_region
  project_name = var.project_name
  environment  = var.environment

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  route_table_ids    = module.vpc.private_route_table_ids
}

module "ecr" {
  source = "../../modules/ecr"

  project_name = var.project_name
  environment  = var.environment

  repository_name      = "${var.project_name}/${var.environment}/app"
  image_tag_mutability = "IMMUTABLE"
  scan_on_push         = true
  force_delete         = true
}

module "cloudwatch" {
  source = "../../modules/cloudwatch"

  project_name = var.project_name
  environment  = var.environment
}

module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name
  environment  = var.environment

  github_repository = var.github_repository
  github_branch     = var.github_branch

  ecr_repository_arn           = module.ecr.repository_arn
  ecs_task_execution_role_name = "${var.project_name}-${var.environment}-ecs-execution"
  ecs_task_role_name           = "${var.project_name}-${var.environment}-ecs-task"
  log_group_arn                = module.cloudwatch.log_group_arn
}

module "alb" {
  source = "../../modules/alb"

  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  vpc_cidr          = var.vpc_cidr
  public_subnet_ids = module.vpc.public_subnet_ids

  target_port                = 8080
  health_check_path          = "/health"
  enable_deletion_protection = false
}

module "ecs" {
  source = "../../modules/ecs"

  project_name       = var.project_name
  environment        = var.environment
  aws_region         = var.aws_region
  vpc_id             = module.vpc.vpc_id
  vpc_cidr           = var.vpc_cidr
  private_subnet_ids = module.vpc.private_subnet_ids

  container_image = "${module.ecr.repository_url}:manual-001"
  container_name  = "app"
  container_port  = 8080
  cpu             = 256
  memory          = 512
  desired_count   = 1
  app_version     = "manual-001"

  execution_role_arn = module.iam.ecs_task_execution_role_arn
  task_role_arn      = module.iam.ecs_task_role_arn

  log_group_name = module.cloudwatch.log_group_name

  alb_security_group_id = module.alb.security_group_id
  target_group_arn      = module.alb.target_group_arn

  execution_role_policy_dependency = module.iam.ecs_task_execution_policy_id

  enable_container_insights = false
}
