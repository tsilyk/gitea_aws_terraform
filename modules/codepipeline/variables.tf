# Repo details

variable "repository" {
}

variable "name"{
}

# Deployment details

variable "codebuild_project_name" {
}

variable "namespace" {
  default = "global"
}

# S3 Bucket, IAM Role, Codestar Connection

variable "s3_bucket_name" {
}

variable "iam_role_arn" {
}

variable "codestar_connection_arn" {
}

variable "elasticapp" {
  default = "gitea-app"
}

variable "beanstalkappenv" {
  default = "gitea-env"
}
