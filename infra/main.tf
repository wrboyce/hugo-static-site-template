terraform {
  cloud {
    organization = "wrboyce"
    workspaces {
      name = FIXME
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

locals {
  project = FIXME
  domain  = "${local.project}.com" # FIXME
  region  = "eu-west-2"

  tags = {
    Project = local.project
    Env     = "prod"
  }
}

provider "aws" {
  region = local.region

  default_tags {
    tags = local.tags
  }
}

provider "aws" {
  alias = "global"

  region = "us-east-1"

  default_tags {
    tags = local.tags
  }
}

module "site" {
  source  = "app.terraform.io/wrboyce/static-website/aws"
  version = "~> 1.0"

  region      = local.region
  project     = local.project
  domain      = local.domain
  github_repo = "wrboyce/${local.domain}"

  providers = {
    aws.global = aws.global
  }
}

output "aws_region" {
  description = "AWS Region"
  value       = module.site.aws_region
}

output "aws_s3_bucket_name" {
  description = "AWS S3 Bucket"
  value       = module.site.bucket_name
}

output "ci_aws_role" {
  description = "AWS Role for CI Runners"
  value       = module.site.aws_role
}
