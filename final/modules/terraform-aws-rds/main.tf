module "vpc" {
  source = "./../terraform-aws-vpc"
}

resource "aws_db_subnet_group" "db_subnet" {
  name       = "db_subnet"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "DB Subnet"
  }
}

resource "aws_db_instance" "education" {
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
  //vpc_security_group_ids = []
  apply_immediately      = true
  publicly_accessible    = false
  skip_final_snapshot    = true
}
