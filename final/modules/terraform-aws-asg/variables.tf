variable "name" {
  type        = string
  description = "Name that will be used in resources names and tags."
  default     = "terraform-aws-asg"
}

variable "image_id" {
  description = "The AMI from which to launch the instance"
  type        = string
  default     = "ami-0721c9af7b9b75114"
}

variable "instance_type" {
  description = "The type of the instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The key name that should be used for the instance"
  type        = string
  default     = "aws"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
  default     = []
}
