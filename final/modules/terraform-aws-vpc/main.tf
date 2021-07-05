resource "aws_vpc" "example" {
  cidr_block = "10.1.0.0/16"
}

resource "aws_subnet" "example" {
  vpc_id = aws_vpc.example.id

  availability_zone = "us-west-2b"
  cidr_block        = cidrsubnet(aws_vpc.example.cidr_block, 4, 1)
}
