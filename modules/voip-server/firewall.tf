resource "linode_firewall" "pbx" {
  label = "${var.name}-firewall"

  # ====================
  # INBOUND
  # ====================
  # Inbound pravidla jsou řešena v rámci IYI-38
  inbound_policy = "DROP"

  # ====================
  # OUTBOUND
  # ====================
  # IYI-58: Allow all outbound traffic (explicit per-protocol)
  outbound_policy = "ACCEPT"

  # --- TCP ---
  outbound {
    label    = "allow-all-tcp-outbound"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "1-65535"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  # --- UDP ---
  outbound {
    label    = "allow-all-udp-outbound"
    action   = "ACCEPT"
    protocol = "UDP"
    ports    = "1-65535"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  # --- ICMP ---
  outbound {
    label    = "allow-icmp-outbound"
    action   = "ACCEPT"
    protocol = "ICMP"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  # ====================
  # TARGET
  # ====================
  linodes = [
    linode_instance.this.id
  ]

  lifecycle {
    create_before_destroy = true
  }
}
