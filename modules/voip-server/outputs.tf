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

output "firewall_inbound_rules" {
  description = "Normalized inbound firewall rules for SIP/RTP (spec only)"
  value = concat(
    local.sip_firewall_rules,
    local.rtp_firewall_rules
  )
}
