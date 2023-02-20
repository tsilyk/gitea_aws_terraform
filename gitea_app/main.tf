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

/*module "codepipeline" {
  source                  = "../modules/codepipeline"
  repository              = "tsilyk/${var.app}"
  name                    = "${var.app}-pipeline"
  codebuild_project_name  = module.codebuild.codebuild_project_name
  s3_bucket_name          = module.s3.s3_bucket
  iam_role_arn            = module.iam.role_arn
  codestar_connection_arn = module.codestar_connection.codestar_arn
  elasticapp              = "${var.app}-app"
  beanstalkappenv         = "${var.app}-env"
}

module "codebuild" {
  source                 = "../modules/codebuild"
  codebuild_project_name = "${var.app}-proj"
  s3_bucket_name         = module.s3.s3_bucket
}

module "codestar_connection" {
  source = "../modules/codestar_connection"
}

module "iam" {
  source = "../modules/iam"
}

module "s3" {
  source = "../modules/s3"
  region = var.region
  app    = var.app
}

module "beanstalk" {
  source           = "../modules/beanstalk"
  public_subnets   = module.vpc-gitea-dev.public_subnet_ids
  vpc_id           = module.vpc-gitea-dev.vpc_id
  elasticapp       = "${var.app}-app"
  beanstalkappenv  = "${var.app}-env"
  instance         = "t2.micro"
  autoscaling_min  = 1
  autoscaling_max  = 1
}*/

module "vpc-gitea-dev" {
  source               = "../modules/vpc"
  env                  = "dev"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  //add tags
}
/*
module "ssm" {
  source = "../modules/ssm"
}

module "rds" {
  source           = "../modules/rds"
  rds_password     = module.ssm.ssm_rds_password
  database_subnets = module.vpc-gitea-dev.private_subnet_ids
  app              = var.app
  vpc_id           = module.vpc-gitea-dev.vpc_id
}*/

