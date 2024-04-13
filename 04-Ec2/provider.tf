terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.43.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "dineshdevops.online"
    key    = "test-ec2_modules"
    region = "us-east-1"
    dynamodb_table = "dineshdevops.online-locking"
  }
}

provider "aws" {
    region = "us-east-1"
 }