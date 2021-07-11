variable "name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "edu-lohika-training-aws-dynamodb"
}

variable "attributes" {
  description = "List of nested attribute definitions. Only required for hash_key and range_key attributes. Each attribute has two properties: name - (Required) The name of the attribute, type - (Required) Attribute type, which must be a scalar type: S, N, or B for (S)tring, (N)umber or (B)inary data"
  type        = list(map(string))
  default     = [
    {
      name = "UserName"
      type = "S"
    }
  ]
}

variable "hash_key" {
  description = "The attribute to use as the hash (partition) key. Must also be defined as an attribute"
  type        = string
  default     = "UserName"
}

variable "write_capacity" {
  description = "The number of write units for this table. If the billing_mode is PROVISIONED, this field should be greater than 0"
  type        = number
  default     = 20
}

variable "read_capacity" {
  description = "The number of read units for this table. If the billing_mode is PROVISIONED, this field should be greater than 0"
  type        = number
  default     = 20
}

variable "timeouts" {
  description = "Updated Terraform resource management timeouts"
  type        = map(string)
  default = {
    create = "10m"
    update = "60m"
    delete = "10m"
  }
}
