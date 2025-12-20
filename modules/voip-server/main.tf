resource "linode_instance" "this" {
  label  = var.name
  region = var.region
  type   = var.instance_type
  image  = var.image

  tags = var.tags
  ipv6 = var.enable_ipv6

  metadata {
    # Optional cloud-init / user-data
    # Passed as-is to the Linode instance.
    # If null, cloud-init is disabled.
    user_data = var.cloud_init_template
  }
}
