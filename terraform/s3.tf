resource "aws_s3_bucket" "config_scripts" {
    bucket  = "mpm-jenkins-cicd-pipeline-config-scripts"
}

resource "aws_s3_bucket_public_access_block" "config_scripts_block" {
  bucket = aws_s3_bucket.config_scripts.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

locals {
  jenkins_scripts_path = abspath("${path.module}/../jenkins/scripts")
}

resource "aws_s3_object" "jenkins_config_scripts" {
  for_each = fileset(local.jenkins_scripts_path, "*")
  bucket   = aws_s3_bucket.config_scripts.id
  key      = "jenkins/${each.value}"
  source   = "${local.jenkins_scripts_path}/${each.value}"
}

resource "aws_s3_object" "jenkins_docker_compose" {
  bucket   = aws_s3_bucket.config_scripts.id
  key      = "jenkins/docker-compose.yml"
  source   = abspath("${path.module}/../jenkins/docker-compose.yml")
}