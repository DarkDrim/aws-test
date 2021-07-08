resource "aws_dynamodb_table" "this" {
  count = 1

  name             = var.name
  billing_mode   = "PROVISIONED"
  hash_key         = var.hash_key
  read_capacity    = var.read_capacity
  write_capacity   = var.write_capacity

  dynamic "attribute" {
    for_each = var.attributes

    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  tags = {
    Name = var.name
  }

  timeouts {
    create = lookup(var.timeouts, "create", null)
    delete = lookup(var.timeouts, "delete", null)
    update = lookup(var.timeouts, "update", null)
  }
}
