# Instance Security group
# holden:ignore:HLD_AWS_092 Bastion needs unrestricted egress for the SSM agent and OS package updates; there is no fixed set of destination CIDRs to scope this to.
resource "aws_security_group" "instance_ssh_access" {
  description = "Allow SSH to instance with ssm agent"
  vpc_id      = var.vpc_id

  ingress {
    description = "Opens SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    self        = true
    cidr_blocks = var.allowed_ips
  }

  egress {
    description = "Open all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    # tfsec:ignore:AWS009
    cidr_blocks = ["0.0.0.0/0"]
  }

}
