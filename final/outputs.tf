output "bastion_public_ip" {
  description = "Public IP of EC2 bastion instance"
  value       = module.ec2.instance_bastion_public_ip
}

output "instance_private_ip" {
  description = "Private IP of EC2 instance"
  value       = module.ec2.instance_private_ip
}

output "elb_url" {
  description = "ELB DNS name"
  value       = module.elb.elb_dns_name
}
