terraform {
  backend "s3" {
    bucket         = "dev-bucket-us-west-2-aman"
    key            = "terraform.tfstate"
    region         = "us-west-2"
  }
}

provider "aws" {
  region  = var.aws_region
}