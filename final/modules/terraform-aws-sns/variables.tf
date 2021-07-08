variable "name" {
  description = "The name of the SNS topic to create"
  type        = string
  default     = "edu-lohika-training-aws-sns-topic"
}

variable "display_name" {
  description = "The display name for the SNS topic"
  type        = string
  default     = "LohikaTrainingSNS"
}
