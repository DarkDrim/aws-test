terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0721c9af7b9b75114"
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }
}

module "network" {
  source = "./modules/terraform-aws-vpc"

  base_cidr_block = "10.0.0.0/8"
}