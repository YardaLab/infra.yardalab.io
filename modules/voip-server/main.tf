resource "linode_instance" "this" {
  label  = var.name
  region = var.region
  type   = var.instance_type
  image  = var.image

  tags = var.tags

  metadata {
    user_data = var.cloud_init_template
  }
}

locals {
  sip_firewall_rules = [
    for p in var.sip_ports : {
      label    = "sip-${p.protocol}-${p.port}"
      protocol = p.protocol
      ports    = tostring(p.port)
      cidrs    = var.sip_source_cidrs
    }
  ]

  rtp_firewall_rules = [
    {
      label    = "rtp-${var.rtp_port_range.from}-${var.rtp_port_range.to}"
      protocol = var.rtp_port_range.protocol
      ports    = "${var.rtp_port_range.from}-${var.rtp_port_range.to}"
      cidrs    = var.rtp_source_cidrs
    }
  ]
}