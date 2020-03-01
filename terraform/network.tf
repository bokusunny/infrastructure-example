resource "aws_vpc" "example_VPC" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = "example_VPC"
  }
}

resource "aws_subnet" "example_subnet" {
  vpc_id     = aws_vpc.example_VPC.id
  cidr_block = "10.0.0.0/24"

  tags = {
    "Name" = "example_subnet"
  }
}
