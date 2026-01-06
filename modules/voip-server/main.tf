############################################
# Linode VoIP Server – Asterisk bootstrap
############################################

############################################
# StackScript: Asterisk installation
#
# NOTE:
# - SSH access is handled exclusively via Linode-managed SSH keys
# - No root password authentication is used
############################################

resource "linode_stackscript" "voip" {
  label       = "yl-voip-bootstrap"
  description = "Install Asterisk PBX (YardaLab VoIP)"
  images      = ["linode/ubuntu22.04"]
  is_public   = false

  script = <<-EOT
#!/bin/bash
set -eux

export DEBIAN_FRONTEND=noninteractive

# Update package index
apt-get update -y

# Install Asterisk PBX
apt-get install -y asterisk

# Enable and start Asterisk service
systemctl enable asterisk
systemctl start asterisk

# Print installed Asterisk version (non-fatal)
asterisk -V || true
EOT
}

############################################
# Linode Instance
#
# SSH access:
# - Root login via SSH key only
# - Key is managed by Linode and injected automatically
############################################

resource "linode_instance" "this" {
  label  = var.name
  region = var.region
  type   = var.instance_type
  image  = "linode/ubuntu22.04"

  # Inject Linode-managed SSH key into root's authorized_keys
  authorized_keys = [
    linode_sshkey.jarda.ssh_key
  ]

  tags = var.tags

  stackscript_id = linode_stackscript.voip.id
}

############################################
# Linode SSH Key
#
# IMPORTANT:
# - This does NOT generate a key
# - The public key must already exist locally
############################################

resource "linode_sshkey" "jarda" {
  label   = "jarda-laptop"
  ssh_key = chomp(file("~/.ssh/id_ed25519.pub"))
}

############################################
# Firewall rule aggregation (SPECIFICATION ONLY)
#
# This local value is used for outputs and documentation.
# It does NOT create any firewall resources by itself.
############################################

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

  # SIP signaling
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

  inbound_firewall_rules = concat(
    local.ssh_firewall_rules,
    local.sip_firewall_rules,
    local.rtp_firewall_rules
  )
}
