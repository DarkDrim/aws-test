resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

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

resource "aws_iam_role" "role" {
  name = "private_ec2_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_policy" "instance_policy" {
  name = "private_s3_dynamodb_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:*"]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = ["dynamodb:*"]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = ["rds:*"]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = ["sqs:*"]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = ["sns:*"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "role_policy_attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.instance_policy.arn
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "private_instance_profile"
  role = aws_iam_role.role.name
}

resource "aws_instance" "bastion_instance" {
  ami           = var.image_id
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  subnet_id = var.public_subnet_ids[0]

  tags = {
    Name = "bastion-instance"
  }
}

resource "aws_instance" "private_server" {
  ami           = var.image_id
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  subnet_id = var.private_subnet_ids[0]
  iam_instance_profile = aws_iam_instance_profile.instance_profile.id

  user_data = filebase64("${path.module}/init.sh")

  tags = {
    Name = var.name
  }
}
