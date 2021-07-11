variable "name" {
  description = "The name of the ELB"
  type        = string
  default     = "elb"
}

variable "internal" {
  description = "If true, ELB will be an internal ELB"
  type        = bool
  default = false
}

variable "cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing"
  type        = bool
  default     = true
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle"
  type        = number
  default     = 60
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "A list of public VPC subnet IDs"
  type        = list(string)
  default     = []
}

variable "autoscaling_group_id" {
  description = "Autoscaling group ID"
  type        = string
}

variable "autoscaling_security_group_id" {
  description = "Autoscaling security group ID"
  type        = string
}
