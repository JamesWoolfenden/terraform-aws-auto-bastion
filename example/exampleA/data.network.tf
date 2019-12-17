data "aws_vpcs" "vpc" {
  tags = var.vpc_tag
}

data "aws_subnet_ids" "subnets" {
  tags = var.subnet_tag

  vpc_id = element(data.aws_vpcs.vpc.ids, 0)
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

variable "subnet_tag" {
  type=map
default={
   Name = "awwe-subn-devtest-h-web-001-1b"
} 
}

variable "vpc_tag" {
  type=map
  default={
    Environment = "Dev/Test"
    Name        = "awwe-vpc-devtest-h-001"
  }
}
