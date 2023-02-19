output "rds_gitea_password" {
  value     = data.aws_ssm_parameter.rds_gitea_password.value
  sensitive = true
}
