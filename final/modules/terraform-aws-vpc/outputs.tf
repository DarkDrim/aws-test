output "vpc" {
  value = aws_vpc.this[0].id
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

output "public_subnets" {
  description = "Public subnets"
  value       = aws_subnet.public.*.id
}
