output "instance_id" {
  description = "Linode instance ID"
  value       = linode_instance.this.id
}

output "ipv4_address" {
  description = "Primary IPv4 address"
  value       = linode_instance.this.ipv4[0]
}
