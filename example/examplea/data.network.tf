data "aws_vpcs" "vpc" {
}
data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [element(tolist(data.aws_vpcs.vpc.ids), 0)]
  }
}
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}
data "aws_caller_identity" "current" {}
