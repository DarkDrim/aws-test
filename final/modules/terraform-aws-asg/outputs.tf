output "autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = aws_autoscaling_group.group.id
}
