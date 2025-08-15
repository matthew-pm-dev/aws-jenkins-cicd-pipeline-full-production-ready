resource "aws_s3_bucket" "config_scripts" {
    bucket  = "mpm-jenkins-cicd-pipeline-config-scripts"
}

resource "aws_s3_bucket_acl" "config_scripts_acl" {
  bucket = aws_s3_bucket.config_scripts.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "config_scripts_block" {
  bucket = aws_s3_bucket.config_scripts.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "jenkins_config_scripts" {
  for_each = fileset(var.jenkins_scripts_path, "*")
  bucket   = aws_s3_bucket.config_scripts.id
  key      = "jenkins/${each.value}"
  source   = "${var.jenkins_scripts_path}/${each.value}"
  acl      = "private"
}
