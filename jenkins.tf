resource "aws_instance" "jenkins" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.jenkins_instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.jenkins.id]
  iam_instance_profile   = aws_iam_instance_profile.jenkins.name

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.jenkins_root_volume_size
    encrypted             = true
    delete_on_termination = true
  }
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  tags = {
    Name    = "${var.project_name}-jenkins-server"
    Project = var.project_name
    Role    = "jenkins"
  }
}
