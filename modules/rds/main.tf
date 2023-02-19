// Generate Password
resource "random_string" "rds_gitea_password" {
  length           = 12
  special          = true
  override_special = "*%#@!!#$&"
}

// Store Password in SSM Parameter Store
resource "aws_ssm_parameter" "rds_gitea_password" {
  name        = "/dev/gitea/mariadb"
  description = "Master Password for RDS MySQL"
  type        = "SecureString"
  value       = random_string.rds_gitea_password.result
}

// Get Password from SSM Parameter Store
data "aws_ssm_parameter" "rds_gitea_password" {
  name       = "/dev/gitea/mariadb"
  depends_on = [aws_ssm_parameter.rds_gitea_password]
}

// Gitea RDS MariaDB database
resource "aws_db_instance" "gitea" {
  identifier           = "dev-gitea-mariadb"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "MariaDB"
  engine_version       = "10.6.10"
  instance_class       = "db.t2.micro"
  db_name              = "gitea"
  username             = "gitea"
  password             = data.aws_ssm_parameter.rds_gitea_password.value
  parameter_group_name = "default.mariadb10.6"
  skip_final_snapshot  = true
  apply_immediately    = true
}
