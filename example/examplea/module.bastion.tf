module "bastion" {
  source        = "../../"
  allowed_ips   = chomp(data.http.myip.body)
  common_tags   = var.common_tags
  vpc_id        = element(tolist(data.aws_vpcs.vpc.ids), 0)
  instance_type = var.instance_type
  subnet_ids    = tolist(data.aws_subnet_ids.subnets.ids)
  name          = var.name
  account_id    = data.aws_caller_identity.current.account_id
}
