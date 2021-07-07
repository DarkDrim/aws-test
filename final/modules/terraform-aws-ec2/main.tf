module "vpc" {
  source = "./../terraform-aws-vpc"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.vpc.vpc

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh_http"
  }
}

resource "aws_instance" "private_server" {
  ami           = var.image_id
  instance_type = var.instance_type
  key_name = var.key_name
  security_groups = [aws_security_group.allow_ssh.id]
  subnet_id = module.vpc.private_subnets[0]

  tags = {
    Name = var.name
  }
}
