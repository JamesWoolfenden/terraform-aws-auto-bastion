resource "aws_launch_configuration" "bastion" {
  image_id             = data.aws_ami.amazon.image_id
  iam_instance_profile = aws_iam_instance_profile.bastion.name
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.instance_ssh_access.id]
  # tfsec:ignore:AWS012
  associate_public_ip_address = true

  ebs_block_device {
    encrypted   = true
    device_name = "/dev/sdb"
    volume_size = "80"
    volume_type = "standard"
  }

  root_block_device {
    encrypted = true
  }
  metadata_options {

    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  lifecycle {
    create_before_destroy = true
  }
}
