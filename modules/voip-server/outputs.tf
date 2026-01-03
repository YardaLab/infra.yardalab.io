output "instance_id" {
  description = "Linode instance ID"
  value       = linode_instance.this.id
}

output "ipv4_address" {
  description = "Primary IPv4 address of the VoIP server"
  value       = linode_instance.this.ip_address
}

output "ipv6_address" {
  description = "Primary IPv6 address of the VoIP server (if enabled)"
  value       = try(linode_instance.this.ipv6, null)
}

output "hostname" {
  description = "Hostname (label) of the VoIP server"
  value       = linode_instance.this.label
}

############################################
# Firewall specification outputs (IYI-57)
############################################

output "firewall_inbound_rules" {
  description = <<EOT
Normalized inbound firewall rule specification derived from module inputs.

This output represents the complete inbound rule set defined by IYI-57:
- SSH administration access (TCP/22, restricted source CIDRs)
- SIP signaling (UDP/TCP 5060, provider IP ranges)
- RTP media traffic (UDP port range, controlled via allow_rtp_from_any)

This output is SPECIFICATION ONLY.
It does NOT apply or modify any firewall resources.
EOT

  value = local.inbound_firewall_rules
}
