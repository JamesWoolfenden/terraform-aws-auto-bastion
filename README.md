[![Slalom][logo]](https://slalom.com)

# terraform-aws-auto-bastion [![Build Status](https://github.com/JamesWoolfenden/terraform-aws-auto-bastion/workflows/Verify%20and%20Bump/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-aws-auto-bastion) [![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-aws-auto-bastion.svg)](https://github.com/JamesWoolfenden/terraform-aws-auto-bastion/releases/latest)

---

It's 100% Open Source and licensed under the [APACHE2](LICENSE).

## Introduction

For Bastions, store ssh key in SSM, with the bastion behind and auto-scaling group.
This bastion now supports Dynamic SSH keys <https://aws.amazon.com/blogs/compute/new-using-amazon-ec2-instance-connect-for-ssh-access-to-your-ec2-instances/>

This means that access to ssh is controlled IAM. Once you have provisioned and add your users to the ssh users group:

```bash
ssh-keygen -t rsa -f mynew_key

aws ec2-instance-connect send-ssh-public-key --region eu-west-1 --instance-id i-0e2f05807e67f0179 --availability-zone eu-west-1a --instance-os-user ec2-user --ssh-public-key file://mynew_key.pub

ssh -i mynew_key ec2-user@ec2-63-32-54-94.eu-west-1.compute.amazonaws.com
```

And you're in!

## Usage

Include this repository as a module in your existing terraform code:

```hcl
module "auto-bastion" {
  source            = "JamesWoolfenden/auto-bastion/aws"
  version           = "0.0.4"
  allowed_ips       = [chomp(data.http.myip.body)]
  common_tags       = var.common_tags
  vpc_id            = element(data.aws_vpcs.vpc.ids, 0)
  instance_type     = var.instance_type
  ssm_standard_role = var.ssm_standard_role
  subnet_ids        = element(data.aws_subnet_ids.subnets.ids, 0)
  name              = var.name
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| account\_id | The AWS account of the instances to connect to:(optional) | `string` | n/a | yes |
| allowed\_ips | Allow this IP through the firewall | `string` | n/a | yes |
| asg | All the Settings of an Auto Scaling Group | `map` | <pre>{<br>  "max_size": 1,<br>  "min_size": 1,<br>  "name": "terraform-asg-bastion"<br>}<br></pre> | no |
| common\_tags | Implements the common tags scheme | `map` | n/a | yes |
| enablesshgroup | Switch to enable ssh group | `number` | `1` | no |
| instance\_type | The EC2 instance type | `string` | `"t2.micro"` | no |
| name | Name of the ec2 instance | `string` | n/a | yes |
| region | The AWS region | `string` | `"eu-west-1"` | no |
| ssh\_name | The name of the ssh group objects | `string` | `"ssh"` | no |
| ssm\_standard\_role | The IAM role to add to the instance profile, the default enables SSM | `string` | `"arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"` | no |
| subnet\_ids | A list of Subnet IDs | `list` | n/a | yes |
| users | List of users to add the ssh users group, (optional) | `list` | <pre>[<br>  "jameswoolfenden"<br>]<br></pre> | no |
| vpc\_id | The ID of the VPC being used | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| bastion | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Help

**Got a question?**

File a GitHub [issue](https://github.com/JamesWoolfenden/terraform-auto-bastion/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/JamesWoolfenden/terraform-auto-bastion/issues) to report any bugs or file feature requests.

## Copyrights

Copyright © 2019-2020 [Slalom, LLC](https://slalom.com)

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

<https://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.

### Contributors

  [![James Woolfenden][jameswoolfenden_avatar]][jameswoolfenden_homepage]<br/>[James Woolfenden][jameswoolfenden_homepage]

  [jameswoolfenden_homepage]: https://github.com/jameswoolfenden
  [jameswoolfenden_avatar]: https://github.com/jameswoolfenden.png?size=150

[logo]: https://gist.githubusercontent.com/JamesWoolfenden/5c457434351e9fe732ca22b78fdd7d5e/raw/15933294ae2b00f5dba6557d2be88f4b4da21201/slalom-logo.png
[website]: https://slalom.com
[github]: https://github.com/jameswoolfenden
[linkedin]: https://www.linkedin.com/company/slalom-consulting/
[twitter]: https://twitter.com/Slalom

[share_twitter]: https://twitter.com/intent/tweet/?text=terraform-auto-bastion&url=https://github.com/JamesWoolfenden/terraform-auto-bastion
[share_linkedin]: https://www.linkedin.com/shareArticle?mini=true&title=terraform-auto-bastion&url=https://github.com/JamesWoolfenden/terraform-auto-bastion
[share_reddit]: https://reddit.com/submit/?url=https://github.com/JamesWoolfenden/terraform-auto-bastion
[share_facebook]: https://facebook.com/sharer/sharer.php?u=https://github.com/JamesWoolfenden/terraform-auto-bastion
[share_email]: mailto:?subject=terraform-auto-bastion&body=https://github.com/JamesWoolfenden/terraform-auto-bastion
