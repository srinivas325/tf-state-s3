terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

}

variable "region" {
  description = "AWS region"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
}
