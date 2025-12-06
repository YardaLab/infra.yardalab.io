module "dns_records" {
  source = "./dns"

  cloudflare_zone_id = var.cloudflare_zone_id
  plantuml_ip        = module.plantuml-server.ipv4_address
}
