terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.69.1"
    }

    github = {
      source  = "integrations/github"
      version = "~> 6.13.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.9.1"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Application = var.developer_portal_application
    }
  }
}

provider "github" {
  owner = var.gh_org
}
