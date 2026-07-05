output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.kk_api.public_ip
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.kk_api.id
}

output "ssh_command" {
  description = "SSH command to connect to the instance"
  value = "ssh -i ~/.ssh/${var.ssh_key_name}.pem ubuntu@${aws_instance.kk_api.public_ip}"
}
