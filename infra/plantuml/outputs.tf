output "vps_ip" {
  value = tolist(linode_instance.plantuml.ipv4)[0]
}

output "plantuml_url" {
  value = "http://${tolist(linode_instance.plantuml.ipv4)[0]}:8080/svg"
}
