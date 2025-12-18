terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "1.82.2"
    }
  }

  backend "s3" {
    bucket = "github-actions-state-file"
    key    = "terraform.tfstate"
    region = "sa-brazil-1"
    endpoints = {
      s3 = "https://obs.sa-brazil-1.myhuaweicloud.com"
    }

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "huaweicloud" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

variable "access_key" {
  type      = string
}

variable "secret_key" {
  type      = string
  sensitive = true
}

variable "region" {
  type    = string
  default = "la-north-2"
}

resource "huaweicloud_vpc" "main" {
  name = "vpc-github-actions"
  cidr = "192.168.0.0/16"
}
