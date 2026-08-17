variable "vpc_id" {
  description = "The ID of the VPC being used"
  type        = string

  validation {
    condition     = can(regex("^vpc-[0-9a-f]{8,17}$", var.vpc_id))
    error_message = "vpc_id must be a valid VPC ID (e.g. vpc-0123456789abcdef0)."
  }
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t2.micro"

  validation {
    condition     = can(regex("^[a-z0-9]+\\.[a-z0-9]+$", var.instance_type))
    error_message = "instance_type must be a valid EC2 instance type (e.g. t3.micro)."
  }
}

variable "ssm_standard_role" {
  description = "The IAM role to add to the instance profile, the default enables SSM"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

  validation {
    condition     = can(regex("^arn:aws:iam::(aws|[0-9]{12}):policy/", var.ssm_standard_role))
    error_message = "ssm_standard_role must be a valid IAM policy ARN."
  }
}

variable "subnet_ids" {
  description = "A list of Subnet IDs"
  type        = list(any)

  validation {
    condition     = length(var.subnet_ids) > 0
    error_message = "subnet_ids must contain at least one subnet ID."
  }
}

variable "allowed_ips" {
  description = "Allow this list of IPs through the firewall"
  type        = list(any)

  validation {
    condition     = alltrue([for ip in var.allowed_ips : can(cidrhost(ip, 0))])
    error_message = "allowed_ips must be a list of valid CIDR blocks (e.g. 203.0.113.0/24)."
  }
}


variable "name" {
  type        = string
  description = "Name of the ec2 instance"

  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]{1,255}$", var.name))
    error_message = "name must be 1-255 characters, using only letters, numbers, hyphens, or underscores."
  }
}

variable "asg" {
  description = "All the Settings of an Auto Scaling Group"
  type = object({
    min_size = number
    max_size = number
    name     = string
  })
  default = {
    min_size = 1
    max_size = 1
    name     = "terraform-asg-bastion"
  }

  validation {
    condition     = var.asg.min_size >= 0 && var.asg.min_size <= var.asg.max_size
    error_message = "asg.min_size must be >= 0 and <= asg.max_size."
  }
}

variable "users" {
  description = "List of users to add the ssh users group, (optional)"
  type        = list(any)
  default     = ["jameswoolfenden"]

  validation {
    condition     = alltrue([for user in var.users : length(user) > 0])
    error_message = "users must be a list of non-empty IAM user names."
  }
}

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "eu-west-1"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]$", var.region))
    error_message = "region must be a valid AWS region identifier (e.g. eu-west-1)."
  }
}

variable "account_id" {
  description = "The AWS account of the instances to connect to:(optional)"
  type        = string

  validation {
    condition     = can(regex("^[0-9]{12}$", var.account_id))
    error_message = "account_id must be a 12-digit AWS account ID."
  }
}

variable "enablesshgroup" {
  type        = number
  description = "Switch to enable ssh group"
  default     = 1

  validation {
    condition     = contains([0, 1], var.enablesshgroup)
    error_message = "enablesshgroup must be 0 or 1 (used directly as a resource count)."
  }
}

variable "ssh_name" {
  type        = string
  description = "The name of the SSH group objects"
  default     = "ssh"

  validation {
    condition     = can(regex("^[a-zA-Z0-9+=,.@_-]{1,128}$", var.ssh_name))
    error_message = "ssh_name must be a valid IAM group name (up to 128 characters)."
  }
}
