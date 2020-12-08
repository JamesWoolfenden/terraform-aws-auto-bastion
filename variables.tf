variable "vpc_id" {
  description = "The ID of the VPC being used"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ssm_standard_role" {
  description = "The IAM role to add to the instance profile, the default enables SSM"
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

variable "subnet_ids" {
  description = "A list of Subnet IDs"
  type        = list(any)
}

variable "allowed_ips" {
  description = "Allow this list of IPs through the firewall"
  type        = list(any)
}

variable "common_tags" {
  type        = map(any)
  description = "Implements the common tags scheme"
}

variable "name" {
  type        = string
  description = "Name of the ec2 instance"
}

variable "asg" {
  description = "All the Settings of an Auto Scaling Group"
  default = {
    min_size = 1
    max_size = 1
    name     = "terraform-asg-bastion"
  }
}

variable "users" {
  description = "List of users to add the ssh users group, (optional)"
  type        = list(any)
  default     = ["jameswoolfenden"]
}

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "account_id" {
  description = "The AWS account of the instances to connect to:(optional)"
  type        = string
}

variable "enablesshgroup" {
  type        = number
  description = "Switch to enable ssh group"
  default     = 1
}

variable "ssh_name" {
  type        = string
  description = "The name of the SSH group objects"
  default     = "ssh"
}
