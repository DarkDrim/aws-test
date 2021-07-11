resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH & HTTP inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
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
  name = "ec2_role"
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
  name = "s3_dynamodb_policy"

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
  name = "instance_profile"
  role = aws_iam_role.role.name
}

resource "aws_launch_template" "instance" {
  name_prefix   = var.name
  image_id      = var.image_id
  instance_type = var.instance_type

  iam_instance_profile {
    name = "instance_profile"
  }

  key_name = var.key_name

  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
  user_data = filebase64("${path.module}/init.sh")
}

resource "aws_autoscaling_group" "group" {
  name                      = var.name
  max_size                  = 2
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  vpc_zone_identifier       = var.subnet_ids

  //target_group_arns         = var.lb_group_arns

  launch_template {
    id      = aws_launch_template.instance.id
    version = "$Latest"
  }
}
