provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  backend "s3" {
    bucket = "sctp-ce8-tfstate"
    key    = "choonyee-s3-tf-ci.tfstate" #Change this
    region = "ap-southeast-1"
  }
}

data "aws_caller_identity" "current" {}

locals {
  name_prefix = split("/", data.aws_caller_identity.current.arn)[1]
  account_id  = data.aws_caller_identity.current.account_id
}

resource "aws_s3_bucket" "s3_tf" {
  #checkov:skip=CKV_AWS_62:Suppress
  #checkov:skip=CKV_AWS_6:Suppress
  #checkov:skip=CKV_AWS_21:Suppress
  #checkov:skip=CKV_AWS_18:Suppress
  #checkov:skip=CKV_AWS_61:Suppress
  #checkov:skip=CKV_AWS_144:Suppress
  #checkov:skip=CKV_AWS_145:Suppress
  bucket = "${local.name_prefix}-s3-tf-bkt-${local.account_id}"
  #checkov:skip=CKV_AWS_62:Suppress
  #checkov:skip=CKV_AWS_6:Suppress
  #checkov:skip=CKV_AWS_61:Suppress
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

terraform {
  required_version = ">= 1.0"
}
