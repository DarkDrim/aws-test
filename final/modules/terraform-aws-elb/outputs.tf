output "lb_id" {
  description = "The ID and ARN of the load balancer."
  value       = concat(aws_lb.this.*.id, [""])[0]
}

output "lb_arn" {
  description = "The ID and ARN of the load balancer."
  value       = concat(aws_lb.this.*.arn, [""])[0]
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = concat(aws_lb.this.*.dns_name, [""])[0]
}

output "lb_zone_id" {
  description = "The zone_id of the load balancer to assist with creating DNS records."
  value       = concat(aws_lb.this.*.zone_id, [""])[0]
}

output "lb_tg_arn" {
  description = "The ID and ARN of the group."
  value       = aws_lb_target_group.this.*.arn
}
