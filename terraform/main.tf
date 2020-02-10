terraform {
    required_version = ">= 0.12"
}

provider "aws" {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region     = "ap-northeast-1"
}

