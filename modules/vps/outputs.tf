output "id" { value = linode_instance.this.id }
output "ip_address" {
  description = "Primary IPv4 address"
  value       = try(tolist(linode_instance.this.ipv4)[0], null)
}
output "status" { value = linode_instance.this.status }