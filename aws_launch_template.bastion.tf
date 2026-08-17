resource "aws_launch_template" "bastion" {
  # holden:ignore:HLD_AWS_018 Bastion host requires a public IP for direct SSH ingress; there is no NAT/proxy layer in front of it by design.

  image_id      = data.aws_ami.amazon.image_id
  instance_type = var.instance_type

  iam_instance_profile {
    name = aws_iam_instance_profile.bastion.name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.instance_ssh_access.id]
  }

  block_device_mappings {
    device_name = "/dev/sdb"
    ebs {
      encrypted   = true
      volume_size = 80
      volume_type = "gp3"
    }
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      encrypted = true
    }
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  lifecycle {
    create_before_destroy = true
  }
}
