resource "aws_iam_group" "ssh" {
  name = "ssh-users"
}

resource "aws_iam_group_policy" "ssh_policy" {
  name  = "ssh_policy_${var.region}"
  group = aws_iam_group.ssh.id

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
  name = "ssh-group-membership"

  users = var.users

  group = aws_iam_group.ssh.name
}
