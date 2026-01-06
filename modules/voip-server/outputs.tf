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
It does NOT create firewall resources.
EOT

  value = local.inbound_firewall_rules
}
