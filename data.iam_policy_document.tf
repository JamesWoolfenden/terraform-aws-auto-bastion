data "aws_iam_policy_document" "assume" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"

      # ssm.amazonaws.com deliberately omitted: this role is only used as the EC2 instance
      # profile role, and the SSM agent gets its credentials via that profile (through IMDS),
      # not by SSM independently calling sts:AssumeRole. Only add it back for a documented
      # use case (e.g. an Automation assume role) that actually needs it.
      identifiers = [
        "ec2.amazonaws.com",
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}
