output "public_connection_string" {
  description = "Copy/Paste/Enter - You are in the matrix"
  value       = "ssh -i ${module.Keypair_module.key_name}.pem ec2-user@${module.ec2_module.public_ip}"
}

output "private_connection_string" {
  description = "Copy/Paste/Enter - You are in the private ec2 instance"
  value       = "ssh -i ${module.Keypair_module.key_name}.pem ec2-user@${module.ec2_module.private_ip}"
}
