resource "aws_security_group" "example_security_group" {
    name        = "example_security_group"
    description = "example security group"
    vpc_id      = aws_vpc.example_VPC.id

    # ingress {
    #   # TLS (change to whatever ports you need)
    #   from_port   = 443
    #   to_port     = 443
    #   protocol    = "tcp"
    #   # Please restrict your ingress to only necessary IPs and ports.
    #   # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    #   cidr_blocks = # add your IP address here
    # }

    tags = {
      Name = "example_security_group"
    }
}

resource "aws_instance" "exmple_instance" {
    ami                         = "ami-0ab3e16f9c414dee7" // 調べる
    ebs_optimized               = false
    instance_type               = "t2.micro"
    monitoring                  = false
    subnet_id                   = aws_subnet.example_subnet.id
    vpc_security_group_ids      = ["sg-033706907752ad02d"] // 変える
    associate_public_ip_address = true
    private_ip                  = "10.0.0.12"
    source_dest_check           = true

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 8
        delete_on_termination = true
    }

    tags = {
        Name = "exmple_instance"
    }
}

resource "aws_eip" "Orbit_api_eip" {
    instance          = aws_instance.exmple_instance.id
    vpc               = true
}
