resource "aws_sns_topic" "this" {
  count = 1

  name = var.name
  display_name = var.display_name

  tags = {
    Name = "sns_topic"
  }
}
