resource "linode_instance" "this" {
  label  = var.name
  region = var.region
  type   = var.instance_type
  image  = var.image

  tags = var.tags

  metadata {
    user_data = templatefile(
      "${path.module}/cloud-init.base.tftpl.yaml",
      {
        ssh_public_keys = var.ssh_public_keys
      }
    )
  }
}

locals {
  # SSH – admin access only
  ssh_firewall_rules = [
    {
      label    = "ssh-admin"
      protocol = "TCP"
      ports    = "22"
      cidrs    = var.ssh_source_cidrs
    }
  ]

  # SIP signaling (UDP / TCP based on input)
  sip_firewall_rules = [
    for p in var.sip_ports : {
      label    = "sip-${lower(p.protocol)}-${p.port}"
      protocol = upper(p.protocol)
      ports    = tostring(p.port)
      cidrs    = var.sip_source_cidrs
    }
  ]

  # RTP media traffic
  rtp_firewall_rules = [
    {
      label    = "rtp-${var.rtp_port_range.from}-${var.rtp_port_range.to}"
      protocol = upper(var.rtp_port_range.protocol)
      ports    = "${var.rtp_port_range.from}-${var.rtp_port_range.to}"
      cidrs    = var.allow_rtp_from_any ? ["0.0.0.0/0"] : var.rtp_source_cidrs
    }
  ]

  # Unified inbound firewall rule set
  # tflint-ignore: terraform_unused_declarations
  inbound_firewall_rules = concat(
    local.ssh_firewall_rules,
    local.sip_firewall_rules,
    local.rtp_firewall_rules
  )
}
