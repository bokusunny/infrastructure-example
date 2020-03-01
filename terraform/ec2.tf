resource "aws_security_group" "example_security_group" {
  name        = "example_security_group"
  description = "allows http from elb and direct ssh"
  vpc_id      = aws_vpc.example_VPC.id

  ingress {
    # TLS (change to whatever ports you need)
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    # cidr_blocks = # add your IP address here
  }

  tags = {
    Name = "example-security_group"
  }
}

resource "aws_instance" "exmple_instance" {
  ami                    = "ami-02ddf94e5edc8e904" // AWS-supported linux image
  availability_zone      = var.default_availability_zone
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.example_subnet.id
  vpc_security_group_ids = ["sg-033706907752ad02d"] // 変える

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
  }

  tags = {
    Name = "exmple-instance"
  }
}

resource "aws_elb" "example_elb" {
  name               = "example-elb"
  availability_zones = var.default_availability_zone_names
  security_groups    = [aws_security_group.example_security_group.id]

  # access_logs {
  #     bucket        = "foo"
  #     bucket_prefix = "bar"
  #     interval      = 60
  # }

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  # listener {
  #     instance_port      = 8000
  #     instance_protocol  = "http"
  #     lb_port            = 443
  #     lb_protocol        = "https"
  #     ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
  # }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = [aws_instance.exmple_instance.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "example-elb"
  }
}
