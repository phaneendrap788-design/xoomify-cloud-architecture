terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "Xoomify"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "Rahitya Busi"
    }
  }
}

terraform {
  backend "local" {}
}


variable "aws_region" {
  default = "us-east-1"
}

variable "environment" {
  default = "production"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_1" {
  default = "10.0.1.0/24"
}

variable "public_subnet_2" {
  default = "10.0.2.0/24"
}

variable "private_subnet_1" {
  default = "10.0.11.0/24"
}

variable "private_subnet_2" {
  default = "10.0.12.0/24"
}


locals {
  project = "xoomify"

  common_tags = {
    Project     = local.project
    Environment = var.environment
  }
}

module "networking" {
  source = "./modules/networking"
}

module "compute" {
  source = "./modules/compute"
}

module "database" {
  source = "./modules/database"
}

module "storage" {
  source = "./modules/storage"
}

module "monitoring" {
  source = "./modules/monitoring"
}

