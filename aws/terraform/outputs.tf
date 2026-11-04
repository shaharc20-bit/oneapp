output "instance_id" {
  value = aws_instance.builder.id
}

output "public_ip" {
  value = aws_instance.builder.public_ip
}

output "public_dns" {
  value = aws_instance.builder.public_dns
}

output "security_group_id" {
  value = aws_security_group.builder.id
}

output "ssh_key_name" {
  value       = aws_key_pair.builder_key.key_name
  description = "Name of the AWS SSH key pair"
}

output "ssh_private_key_path" {
  value       = abspath(local_file.private_key.filename)
  description = "Path to the generated private SSH key"
}

output "ssh_command" {
  value = "ssh -i ${abspath(local_file.private_key.filename)} ubuntu@${aws_instance.builder.public_ip}"
}

output "app_url" {
  value = "http://${aws_instance.builder.public_ip}:5001"
}

output "jenkins_url" {
  value = "http://${aws_instance.builder.public_ip}:8080"
}

output "allowed_cidrs" {
  value = local.allowed_cidrs
}
