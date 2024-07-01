terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.52.0"
    }
  }
  backend "s3" {
    bucket = "expense-dev-projects"
    key    = "vpc-new-module-frontend"
    region = "us-east-1"
    dynamodb_table =  "expense-dev-locking"
  }

}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}