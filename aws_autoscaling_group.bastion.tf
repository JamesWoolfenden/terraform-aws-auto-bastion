resource "aws_autoscaling_group" "bastion" {
  name                 = var.asg["name"]
  launch_configuration = aws_launch_configuration.bastion.name
  min_size             = var.asg["min_size"]
  max_size             = var.asg["max_size"]
  vpc_zone_identifier  = var.subnet_ids

  lifecycle {
    create_before_destroy = true
  }
}
