terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  backend "s3"{
   bucket = "mentayk-tfstate-s3"
   key = "stg_menta/vpc/terraform.tfstate"
   region = "ap-northeast-1"
  }
}
provider "aws" {
  region  = "ap-northeast-1"
}

