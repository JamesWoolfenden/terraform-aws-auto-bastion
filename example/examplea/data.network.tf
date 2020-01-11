data "aws_vpcs" "vpc" {
}

data "aws_subnet_ids" "subnets" {
  vpc_id = element(tolist(data.aws_vpcs.vpc.ids), 0)
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

data "aws_caller_identity" "current" {}