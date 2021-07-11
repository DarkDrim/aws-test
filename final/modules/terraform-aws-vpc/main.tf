resource "aws_vpc" "this" {
  count = 1
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name      = var.name
    Module    = path.module
    Workspace = terraform.workspace
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_internet_gateway" "this" {
  count = 1
  vpc_id = aws_vpc.this[0].id

  tags = {
    Name      = var.name
    Module    = path.module
    Workspace = terraform.workspace
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip" "nat" {
  count = 1
  vpc = true

  tags = {
    Name      = var.name
    Module    = path.module
    Workspace = terraform.workspace
    Network   = "NAT"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "nat" {
  count = 1
  allocation_id = aws_eip.nat[0].id

  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name      = var.name
    Module    = path.module
    Workspace = terraform.workspace
  }

  depends_on = [aws_internet_gateway.this[0]]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "public" {
  count = 2
  cidr_block              = cidrsubnet(var.cidr_block, 4, 0 + count.index)
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.this[0].id
  //availability_zone = "us-west-2a"
  availability_zone       = data.aws_availability_zones.this.names[count.index]

  tags = {
    Name = var.name

    Module     = path.module
    Workspace  = terraform.workspace
    SubnetType = "public"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table" "public" {
  count = 1
  vpc_id = aws_vpc.this[0].id

  tags = {
    Name = var.name

    Module     = path.module
    Workspace  = terraform.workspace
    SubnetType = "public"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route" "public" {
  count = 1
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "public" {
  count = 2
  route_table_id = aws_route_table.public[0].id
  subnet_id      = aws_subnet.public[count.index].id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "private" {
  count = 2
  cidr_block              = cidrsubnet(var.cidr_block, 4, 4 + count.index)
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.this[0].id
  //availability_zone = "us-west-2a"
  availability_zone       = data.aws_availability_zones.this.names[count.index]

  tags = {
    Name = var.name

    Module     = path.module
    Workspace  = terraform.workspace
    Network    = "NAT"
    SubnetType = "private"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table" "private" {
  count = 1
  vpc_id = aws_vpc.this[0].id

  tags = {
    Name = var.name

    Module     = path.module
    Workspace  = terraform.workspace
    SubnetType = "private"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route" "private" {
  count = 1
  route_table_id         = aws_route_table.private[0].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat[0].id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "private" {
  count = 2
  route_table_id = aws_route_table.private[0].id
  subnet_id      = aws_subnet.private[count.index].id

  lifecycle {
    create_before_destroy = true
  }
}
