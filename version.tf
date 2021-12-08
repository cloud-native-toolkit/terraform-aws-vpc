terraform {
  required_version = ">= 0.15.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"

    }
  }
}

provider "aws" {
  region = "ap-south-1"
  default_tags {
    tags = {
      project = "swe"
    }
  }
}