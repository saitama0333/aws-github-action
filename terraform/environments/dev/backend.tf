terraform {
  backend "s3" {
    bucket       = "aws-github-action-tfstate-960645511169"
    key          = "environments/dev/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}