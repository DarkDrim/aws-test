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
  region  = "us-west-2"
}

module "network" {
  source = "./modules/terraform-aws-vpc"

  name = "VPC"
  cidr_block = "10.0.0.0/16"
}

module "asg" {
  source = "./modules/terraform-aws-asg"

  name = "ASG"
  vpc_id = module.network.vpc
  subnet_ids = module.network.public_subnets
}

module "ec2" {
  source = "./modules/terraform-aws-ec2"

  name = "Private EC2 instance"
  vpc_id = module.network.vpc
  public_subnet_ids = module.network.public_subnets
  private_subnet_ids = module.network.private_subnets
}

module "dynamodb" {
  source = "./modules/terraform-aws-dynamodb"
}

module "rds" {
  source = "./modules/terraform-aws-rds"

  private_subnet_ids = module.network.private_subnets
}

module "sns" {
  source = "./modules/terraform-aws-sns"
}

module "sqs" {
  source = "./modules/terraform-aws-sqs"
}

module "elb" {
  source = "./modules/terraform-aws-elb"

  public_subnet_ids = module.network.public_subnets
  autoscaling_group_id = module.asg.autoscaling_group_id
}
