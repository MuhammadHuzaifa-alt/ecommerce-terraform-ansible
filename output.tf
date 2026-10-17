output "vpc_id" {
  description = "ID of the new ecommerce VPC"
  value       = aws_vpc.ecommerce.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "ec2_instance_id" {
  description = "ID of the new ecommerce EC2 instance"
  value       = aws_instance.ecommerce.id
}

output "ec2_public_ip" {
  description = "Public IPv4 address for Ansible SSH access"
  value       = aws_instance.ecommerce.public_ip
}

output "ec2_private_ip" {
  description = "Private IPv4 address of the EC2 instance"
  value       = aws_instance.ecommerce.private_ip
}

output "ec2_iam_role_name" {
  description = "IAM role attached to the ecommerce EC2 instance"
  value       = aws_iam_role.ecommerce_ec2.name
}

output "ecr_registry_url" {
  description = "ECR registry for this AWS account and region"
  value       = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com"
}

output "ecr_backend_repository_url" {
  value = aws_ecr_repository.backend.repository_url
}

output "ecr_client_repository_url" {
  value = aws_ecr_repository.client.repository_url
}

output "ecr_admin_repository_url" {
  value = aws_ecr_repository.admin.repository_url
}

data "aws_caller_identity" "current" {}
