terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.41.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "4.0.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
