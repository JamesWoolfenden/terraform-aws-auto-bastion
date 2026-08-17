resource "aws_iam_group" "ssh" {
  count = var.enablesshgroup
  name  = var.ssh_name
}

resource "aws_iam_group_policy" "ssh_policy" {
  # Resource below is "instance/*" (every instance in the account/region), which alone would let
  # any group member push an SSH key to any instance, not just the bastion. It is deliberately
  # narrowed by the aws:ResourceTag/Name condition, matched only by instances the ASG tags with
  # Name = var.name (aws_autoscaling_group.bastion.tf). The wildcard exists because ASG-managed
  # instance IDs are dynamic and can't be pinned to a specific ARN here without going stale on
  # every instance replacement -- do not remove the Condition block.
  count = var.enablesshgroup
  name  = var.ssh_name
  group = aws_iam_group.ssh[0].id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "SendSSHPublicKeyScopedToBastionByNameTag",
            "Effect": "Allow",
            "Action": [
                "ec2-instance-connect:SendSSHPublicKey"
            ],
            "Resource": [
                "arn:aws:ec2:${var.region}:${var.account_id}:instance/*"
            ],
            "Condition": {
                "StringEquals": {
                    "ec2:osuser": "ec2-user",
                    "aws:ResourceTag/Name": "${var.name}"
                }
            }
        }
    ]
}
EOF
}

resource "aws_iam_group_membership" "ssh" {
  count = var.enablesshgroup
  name  = var.ssh_name
  users = var.users
  group = aws_iam_group.ssh[0].name
}
