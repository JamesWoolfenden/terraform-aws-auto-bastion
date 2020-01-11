resource "aws_launch_configuration" "bastion" {
  image_id                    = data.aws_ami.amazon.image_id
  iam_instance_profile        = aws_iam_instance_profile.bastion.name
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.instance_ssh_access.id]
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}
