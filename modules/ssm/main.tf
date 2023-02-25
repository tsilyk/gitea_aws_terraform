// Generate Password
resource "random_string" "rds_password" {
  length           = 12
  special          = true
  override_special = "@"
}

// Store Password in SSM Parameter Store
resource "aws_ssm_parameter" "rds_password" {
  name        = var.ssm_password_name
  description = "Master Password for RDS Database"
  type        = "SecureString"
  value       = random_string.rds_password.result
}

// Get Password from SSM Parameter Store
data "aws_ssm_parameter" "rds_password" {
  name       = var.ssm_password_name
  depends_on = [aws_ssm_parameter.rds_password]
}

