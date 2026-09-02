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

module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name
  environment  = var.environment

  github_repository = var.github_repository
  github_branch     = var.github_branch

  ecr_repository_arn = module.ecr.repository_arn
}