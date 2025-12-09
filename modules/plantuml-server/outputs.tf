# ──────────────────────────────────────────────────────────────
# File: outputs.tf
# Purpose: Output values from plantuml-server module
# Clean version without Docker provider dependencies
# ──────────────────────────────────────────────────────────────

output "domain" {
  value       = var.domain
  description = "Domain used for PlantUML server."
}

output "ssl_enabled" {
  value       = var.ssl_enabled
  description = "SSL enabled flag."
}

output "theme" {
  value       = var.theme
  description = "Selected PlantUML theme."
}

output "server_url" {
  description = "Public URL of the PlantUML server (including /svg endpoint)."

  value = format(
    "%s://%s:%d/svg",
    var.ssl_enabled ? "https" : "http",
    tolist(linode_instance.plantuml.ipv4)[0],
    var.internal_port
  )
}

output "ipv4_address" {
  description = "Public IPv4 address of the PlantUML server."
  value       = tolist(linode_instance.plantuml.ipv4)[0]
}
