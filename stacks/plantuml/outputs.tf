output "vps_ip" {
  description = "Public IPv4 address of the PlantUML server"
  value       = module.plantuml_server.vps_ipv4
}

output "plantuml_url" {
  description = "PlantUML render URL"
  value       = module.plantuml_server.plantuml_url
}
