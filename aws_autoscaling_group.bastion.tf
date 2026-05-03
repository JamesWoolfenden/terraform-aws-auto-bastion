resource "aws_autoscaling_group" "bastion" {
  # checkov:skip=CKV_AWS_153: Bastion host does not require load balancer association
  name                = var.asg["name"]
  min_size            = var.asg["min_size"]
  max_size            = var.asg["max_size"]
  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.bastion.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }
}
