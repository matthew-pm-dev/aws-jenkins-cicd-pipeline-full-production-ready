terraform {
  required_version = "= 1.12.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 6.8.0"
    }
  }
}

provider "aws" {
  region = "${var.region}"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_ec2_managed_prefix_list" "ec2_instance_connect" {
  name = "com.amazonaws.${var.region}.ec2-instance-connect"
}