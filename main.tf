provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = "private"
}

variable "region" {
  description = "AWS region"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
}
