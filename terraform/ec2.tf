resource "aws_security_group" "example_security_group" {
  name        = "example_security_group"
  description = "allows http from elb and direct ssh"
  vpc_id      = aws_vpc.example_VPC.id

  tags = {
    Name = "example-security_group"
  }
}

resource "aws_security_group_rule" "allow_all_http" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.example_security_group.id
}

resource "aws_security_group_rule" "allow_ssh" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  cidr_blocks = [
    "61.124.137.74/32",  # 家
    "150.249.207.30/32", # Progate Office
  ]

  security_group_id = aws_security_group.example_security_group.id
}

resource "aws_security_group_rule" "allow_all_outbound_traffic" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.example_security_group.id
}

resource "aws_instance" "exmple_instance" {
  ami                         = "ami-02ddf94e5edc8e904" # AWS-supported linux image
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.example_subnet.id
  vpc_security_group_ids      = [aws_security_group.example_security_group.id]
  key_name                    = "terraform-example"
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
  }

  tags = {
    Name = "exmple-instance"
  }
}

# resource "aws_elb" "example_elb" {
#   name               = "example-elb"
#   availability_zones = var.default_availability_zone_names
#   security_groups    = [aws_security_group.example_security_group.id]

#   listener {
#     instance_port     = 80
#     instance_protocol = "http"
#     lb_port           = 80
#     lb_protocol       = "http"
#   }

#   health_check {
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 3
#     target              = "HTTP:80/"
#     interval            = 30
#   }

#   instances                   = [aws_instance.exmple_instance.id]
#   cross_zone_load_balancing   = true
#   idle_timeout                = 400
#   connection_draining         = true
#   connection_draining_timeout = 400

#   tags = {
#     Name = "example-elb"
#   }
# }
