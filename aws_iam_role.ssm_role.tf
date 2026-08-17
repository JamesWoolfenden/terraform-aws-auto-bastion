resource "aws_iam_role" "ssm_role" {
  # holden:ignore:HLD_AWS_276 assume_role_policy references data.aws_iam_policy_document.assume's
  # .json output (a structured data source), not a literal JSON string, so HLD_AWS_276 can never
  # resolve it. The wildcard-principal concern is already covered on the underlying data source
  # itself by HLD_AWS_143/HLD_AWS_269, which both confirm Pass (principal is scoped to
  # ec2.amazonaws.com, not a wildcard).
  assume_role_policy = data.aws_iam_policy_document.assume.json
  # Trust policy only allows ec2.amazonaws.com/ssm.amazonaws.com to assume this role for discrete
  # per-instance work, so the session is kept at AWS's floor rather than the 12h ceiling.
  max_session_duration = 3600
}

resource "aws_iam_role_policy_attachment" "ssm_standard" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = var.ssm_standard_role
}

resource "aws_iam_instance_profile" "bastion" {
  role = aws_iam_role.ssm_role.name
}
