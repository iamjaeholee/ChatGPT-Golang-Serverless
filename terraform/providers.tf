terraform {
  required_version = "~> 1.1.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.15"
    }
  }
}

provider "aws" {
  region  = "ap-northeast-2"
  profile = "dev"
}
