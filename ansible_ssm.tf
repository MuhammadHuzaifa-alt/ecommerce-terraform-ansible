
resource "aws_s3_bucket" "ansible_ssm" {
  bucket = "${var.project_name}-ansible-ssm-${data.aws_caller_identity.current.account_id}-${var.aws_region}"

  force_destroy = false

  tags = {
    Name      = "${var.project_name}-ansible-ssm"
    Project   = var.project_name
    ManagedBy = "Terraform"
    Purpose   = "Ansible SSM file transfer"
  }
}

resource "aws_s3_bucket_public_access_block" "ansible_ssm" {
  bucket = aws_s3_bucket.ansible_ssm.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "ansible_ssm" {
  bucket = aws_s3_bucket.ansible_ssm.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
