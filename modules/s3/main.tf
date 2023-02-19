resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "codepipeline-eu-central-1-gitea"
  force_destroy = true
}
