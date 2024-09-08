terraform {
  required_version = "~> 1.0"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 4.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "tenzin-io"
    key            = "terraform/public-ecr.state"
    dynamodb_table = "tenzin-io"
    region         = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_ecrpublic_repository" "actions_runner_nvidia" {
  repository_name = "actions-runner-nvidia"

  catalog_data {
    about_text        = "https://github.com/tenzin-io"
    description       = "An actions runner image that includes Nvidia GPU access."
    architectures     = ["x86-64"]
    operating_systems = ["Linux"]
    usage_text        = "Used for self-hosted GitHub Actions runners"
  }

  tags = {
    "repository-url" = "production"
  }
}