module "bastion" {
  source            = "../../"
  allowed_ips       = chomp(data.http.myip.body)
  common_tags       = var.common_tags
  vpc_id            = element(data.aws_vpcs.vpc.ids, 0)
  instance_type     = var.instance_type
  ssm_standard_role = var.ssm_standard_role
  subnet_ids        = tolist(data.aws_subnet_ids.subnets.ids)
  environment       = var.environment
  name              = var.name
}
