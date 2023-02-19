provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "gitea-terraform-remote-state"
    key    = "dev/gitea/root/terraform.tfstate"
    region = "eu-central-1"
  }
}

module "codepipeline" {
  source                  = "./modules/codepipeline"
  repository              = "tsilyk/gitea"
  name                    = "gitea-pipeline"
  codebuild_project_name  = module.codebuild.codebuild_project_name
  s3_bucket_name          = module.s3.s3_bucket
  iam_role_arn            = module.iam.role_arn
  codestar_connection_arn = module.codestar_connection.codestar_arn
}

module "codebuild" {
  source                 = "./modules/codebuild"
  codebuild_project_name = "gitea-proj"
}

module "codestar_connection" {
  source = "./modules/codestar_connection"
}

module "iam" {
  source = "./modules/iam"
}

module "s3" {
  source = "./modules/s3"
}

module "beanstalk" {
  source = "./modules/beanstalk"
}

module "vpc-gitea-dev" {
  source               = "./modules/vpc"
  env                  = "dev"
  vpc_cidr             = "10.10.0.0/16"
  public_subnet_cidrs  = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  private_subnet_cidrs = ["10.10.11.0/24", "10.10.22.0/24", "10.10.33.0/24"]
}
