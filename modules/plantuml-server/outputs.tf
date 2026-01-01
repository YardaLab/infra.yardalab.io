# ──────────────────────────────────────────────────────────────
# File: outputs.tf
# Purpose: Public outputs of the plantuml-server module
# ──────────────────────────────────────────────────────────────

output "vps_ipv4" {
  description = "Public IPv4 address of the PlantUML server."
  value       = tolist(linode_instance.plantuml.ipv4)[0]
}

output "plantuml_url" {
  description = "Public PlantUML render endpoint."

  value = format(
    "%s://%s:%d/svg",
    var.ssl_enabled ? "https" : "http",
    var.domain != "" ? var.domain : tolist(linode_instance.plantuml.ipv4)[0],
    var.internal_port
  )
}
