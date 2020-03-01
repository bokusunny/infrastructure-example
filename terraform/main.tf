terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = ">= 2.43.0"
  }
  experiments = [variable_validation]
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "ap-northeast-1"
}

