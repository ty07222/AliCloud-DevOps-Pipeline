terraform {
  required_version = ">= 1.0.0"

  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = ">= 1.212.0"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}
