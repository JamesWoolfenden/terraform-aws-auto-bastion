data "aws_default_tags" "current" {}

resource "aws_autoscaling_group" "bastion" {
  # holden:ignore:HLD_AWS_209 Single bastion host, not a traffic-scaled fleet -- the only events
  # that replace this instance are health-check failure, spot interruption, or AZ rebalance, and
  # in all of those cases the replacement should come up on the latest patched AMI/config, not a
  # version pinned months ago. This module's own terraform apply is already the deliberate
  # promotion gate; pinning would just add a second bump ritual for a resource with no fleet
  # blast radius to protect against.
  name                = var.asg["name"]
  min_size            = var.asg["min_size"]
  max_size            = var.asg["max_size"]
  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.bastion.id
    version = aws_launch_template.bastion.latest_version
  }

  # aws_autoscaling_group has a custom tag implementation that provider-level
  # default_tags does not propagate to, so it is re-applied explicitly here.
  dynamic "tag" {
    for_each = merge(data.aws_default_tags.current.tags, { Name = var.name })
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
