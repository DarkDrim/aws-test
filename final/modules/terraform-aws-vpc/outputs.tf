output "vpc" {
  value = try(aws_vpc.this[0], null)
}

output "nat_gateway" {
  value = try(aws_nat_gateway.nat, null)
}

output "subnets" {
  value = {
    public  = try(aws_subnet.public, null)
    private = try(aws_subnet.private, null)
  }
}
