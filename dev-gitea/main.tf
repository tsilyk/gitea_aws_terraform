provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment = "Development"
      Owner       = "Yuriy Tsilyk"
      App         = "Gitea"
      Company     = "SoftServe"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "gitea-terraform-remote-state"
    key    = "dev/gitea/root/terraform.tfstate"
    region = "eu-central-1"
  }
}

module "codepipeline" {
   source                  = "../modules/codepipeline"
   repository              = "tsilyk/${var.app}"
   name                    = "${var.env}-${var.app}-pipeline"
   codebuild_project_name  = module.codebuild.codebuild_project_name
   s3_bucket_name          = module.s3.s3_bucket
   iam_role_arn            = module.iam.role_arn
   codestar_connection_arn = module.codestar_connection.codestar_arn
   elasticapp              = "${var.app}-app"
   beanstalkappenv         = "${var.env}-${var.app}-env"
 }

module "codebuild" {
  source                 = "../modules/codebuild"
  codebuild_project_name = "${var.env}-${var.app}-proj"
  s3_bucket_name         = module.s3.s3_bucket
}

module "codestar_connection" {
  source = "../modules/codestar_connection"
}

module "iam" {
  source = "../modules/iam"
}

module "s3" {
  source  = "../modules/s3"
  region  = var.region
  env_app = "${var.env}-${var.app}"
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
}

module "vpc-gitea-dev" {
  source                = "../modules/vpc"
  env_app               = "${var.env}-${var.app}"
  vpc_cidr              = "10.0.0.0/16"
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = []
  isolated_subnet_cidrs = var.isolated_subnet_cidrs
}

module "ssm" {
  source = "../modules/ssm"
}

module "rds" {
  source                      = "../modules/rds"
  rds_password                = module.ssm.ssm_rds_password
  database_subnets            = module.vpc-gitea-dev.isolated_subnet_ids
  env_app                     = "${var.env}-${var.app}"
  vpc_id                      = module.vpc-gitea-dev.vpc_id
  sg_ingress_database_subnets = var.public_subnet_cidrs
}

module "efs" {
  source = "../modules/efs"
  vpc_id                 = module.vpc-gitea-dev.vpc_id
  name                   = "${var.env}-${var.app}-efs"
  subnet_ids             = module.vpc-gitea-dev.isolated_subnet_ids
  security_group_ingress = {
    default = {
      description = "NFS Inbound"
      from_port   = 2049
      protocol    = "tcp"
      to_port     = 2049
      self        = false
      cidr_blocks = var.public_subnet_cidrs
    }
  }
  lifecycle_policy = [{
    "transition_to_ia" = "AFTER_30_DAYS"
  }]
}
