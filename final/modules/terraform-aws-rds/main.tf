resource "aws_security_group" "this" {
  name        = "allow_db"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_db"
  }
}

resource "aws_db_subnet_group" "db_subnet" {
  name       = "db_subnet"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "DB Subnet"
  }
}

resource "aws_db_instance" "lohikards" {
  identifier             = var.identifier
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  username               = var.username
  password               = var.password
  port                   = var.port
  name                   = var.name
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [aws_security_group.this.id]
  apply_immediately      = true
  publicly_accessible    = false
  skip_final_snapshot    = true
}
