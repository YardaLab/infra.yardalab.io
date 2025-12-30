terraform {
  required_version = ">= 1.9.0"

  required_providers {
    linode = {
      source  = "linode/linode"
      version = ">= 3.5.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
  }
}

provider "linode" {
  token = var.linode_token
}
