variable "name" {
  type        = string
  description = "Name that will be used in resources names and tags."
  default     = "terraform-aws-vpc-public-private"
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC."
  default     = "10.0.0.0/16"

  validation {
    condition     = can(regex("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\\/(1[6-9]|2[0-8]))$", var.cidr_block))
    error_message = "CIDR block parameter must be in the form x.x.x.x/16-28."
  }
}
