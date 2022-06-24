terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.14.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.5.0"
    }
  }
}
