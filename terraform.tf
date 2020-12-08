terraform {
  required_providers {
    aws = {
      version = "3.20.0"
      source  = "hashicorp/aws"
    }

    tls = {
      version = "3.0"
    }

    external = {
      version = "2.0"
    }

    http = {
      version = "2.0"
    }

    local = {
      version = "2.0"
    }
  }
}
