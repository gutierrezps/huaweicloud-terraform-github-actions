terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "1.82.2"
    }
  }

  backend "s3" {
    # Add -backend-config="bucket=obs-bucket-name" when running terraform command
    # bucket = "obs-bucket-name"
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
  access_key = var.hwc_access_key
  secret_key = var.hwc_secret_key
}

variable "hwc_access_key" {
  type        = string
  description = "Access Key (AK) of your Huawei Cloud account or IAM User"
}

variable "hwc_secret_key" {
  type        = string
  sensitive   = true
  description = "Secret Access Key (SK) of your Huawei Cloud account or IAM User"
}

variable "region" {
  type        = string
  description = "Region where cloud resources will be deployed by default"
  default     = "sa-brazil-1"
}

resource "huaweicloud_vpc" "main" {
  name = "vpc-github-actions"
  cidr = "192.168.0.0/16"
}
