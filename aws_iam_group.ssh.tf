resource "aws_iam_group" "ssh" {
  count = var.enablesshgroup
  name  = var.ssh_name
}

resource "aws_iam_group_policy" "ssh_policy" {
  count = var.enablesshgroup
  name  = var.ssh_name
  group = aws_iam_group.ssh[0].id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2-instance-connect:SendSSHPublicKey"
            ],
            "Resource": [
                "arn:aws:ec2:${var.region}:${var.account_id}:instance/*"
            ],
            "Condition": {
                "StringEquals": {
                    "ec2:osuser": "ec2-user"
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
