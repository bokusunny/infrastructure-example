variable "aws_access_key" {}
variable "aws_secret_key" {}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "ap-northeast-1"
}

resource "aws_instance" "example" {
  ami           = "ami-f80e0596"
  instance_type = "t2.micro"
  tags = {
    Name = "sunny_test"
  }
}
