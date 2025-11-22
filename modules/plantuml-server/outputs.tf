output "http_url" {
  description = "Internal HTTP base URL"
  value       = "http://${var.host_ip}:${var.host_port}"
}

output "container_id" {
  description = "Container ID"
  value       = docker_container.plantuml.id
}

output "volume_name" {
  description = "Jetty tmp volume"
  value       = docker_volume.jetty_tmp.name
}

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
  description = "Fully composed URL of the PlantUML server."

  value = format(
    "%s://%s:%d",
    var.ssl_enabled ? "https" : "http",
    var.domain,
    var.external_port
  )
}
