data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "${var.app}-codepipeline-${var.region}-${data.aws_caller_identity.current.account_id}"
  force_destroy = true
}
