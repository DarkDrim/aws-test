output "autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = aws_autoscaling_group.group.id
}

output "autoscaling_security_group_id" {
  description = "The security group of autoscaling group"
  value       = aws_security_group.allow_ssh_http.id
}
