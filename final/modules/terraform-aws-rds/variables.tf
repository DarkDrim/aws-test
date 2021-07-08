variable "identifier" {
  description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier"
  type        = string
  default     = "lohikadb"
}

variable "engine" {
  description = "The database engine to use"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "12.5"
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t2.micro"
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 10
}

variable "name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = "EduLohikaTrainingAwsRds"
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
  default     = "rootuser"
}

variable "password" {
  description = "Password for the master DB user"
  type        = string
  default     = "rootuser"
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = number
  default     = 5432
}

variable "private_subnet_ids" {
  description = "A list of private VPC subnet IDs"
  type        = list(string)
  default     = []
}
