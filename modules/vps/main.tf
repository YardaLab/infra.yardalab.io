terraform {
  required_version = ">= 1.6.0"
  required_providers {
    linode = {
      source  = "linode/linode"
      version = ">= 3.5.0"
    }
  }
}

resource "linode_instance" "this" {
  label           = var.label
  region          = var.region
  type            = var.instance_type
  image           = var.image
  authorized_keys = var.ssh_keys
  root_pass       = var.root_pass
  tags            = var.tags
  backups_enabled = var.backups_enabled
  private_ip      = var.private_ip
}
