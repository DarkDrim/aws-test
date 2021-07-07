output "instance_private_ip" {
  description = "Private IP of EC2 instance"
  value       = module.ec2.instance_private_ip
}
