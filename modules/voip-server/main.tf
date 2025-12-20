resource "linode_instance" "this" {
  label  = var.name
  region = var.region
  type   = var.instance_type
  image  = var.image

  tags = var.tags

  ipv6 = var.enable_ipv6
}
