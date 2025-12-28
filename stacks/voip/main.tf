terraform {
  required_version = ">= 1.5.0"

  required_providers {
    linode = {
      source  = "linode/linode"
      version = "~> 2.0"
    }
  }
}

provider "linode" {
  token = var.linode_token
}

module "voip_server" {
  source = "git::https://github.com/YardaLab/infra.yardalab.io.git//modules/voip-server?ref=v0.1.0"

  name        = var.name
  environment = var.environment

  region        = var.region
  instance_type = var.instance_type
  image         = var.image
  hostname      = var.hostname

  enable_ipv6 = var.enable_ipv6
  tags        = var.tags
}

