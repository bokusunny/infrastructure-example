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
  vpc_id            = aws_vpc.example_VPC.id
  availability_zone = var.default_availability_zone
  cidr_block        = "10.0.0.0/27"

  tags = {
    "Name" = "example_subnet"
  }
}

resource "aws_internet_gateway" "example_gateway" {
  vpc_id = aws_vpc.example_VPC.id

  tags = {
    Name = "example_gateway"
  }
}

resource "aws_route_table" "example_route_table" {
  vpc_id = aws_vpc.example_VPC.id

  tags = {
    Name = "example_route_table"
  }
}

resource "aws_route" "example_route" {
  route_table_id         = aws_route_table.example_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.example_gateway.id
}

resource "aws_route_table_association" "example_route_table_gateway_association" {
  // 明示的な関連付けが必要
  subnet_id      = aws_subnet.example_subnet.id
  route_table_id = aws_route_table.example_route_table.id
}
