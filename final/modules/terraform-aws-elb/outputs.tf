output "elb_id" {
  description = "The name of the ELB"
  value       = concat(aws_elb.this.*.id, [""])[0]
}

output "elb_arn" {
  description = "The ARN of the ELB"
  value       = concat(aws_elb.this.*.arn, [""])[0]
}

output "elb_name" {
  description = "The name of the ELB"
  value       = concat(aws_elb.this.*.name, [""])[0]
}

output "elb_dns_name" {
  description = "The DNS name of the ELB"
  value       = concat(aws_elb.this.*.dns_name, [""])[0]
}

output "elb_instances" {
  description = "The list of instances in the ELB"
  value       = flatten(aws_elb.this.*.instances)
}

output "elb_zone_id" {
  description = "The canonical hosted zone ID of the ELB (to be used in a Route 53 Alias record)"
  value       = concat(aws_elb.this.*.zone_id, [""])[0]
}
