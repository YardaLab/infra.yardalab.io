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