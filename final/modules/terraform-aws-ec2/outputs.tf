output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.private_server.id
}

output "instance_bastion_public_ip" {
  description = "Public IP address of the Bastion EC2 instance"
  value       = aws_instance.bastion_instance.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.private_server.private_ip
}
