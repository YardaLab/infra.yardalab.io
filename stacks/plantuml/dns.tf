resource "cloudflare_dns_record" "plantuml" {
  zone_id = var.cloudflare_zone_id

  name    = var.domain
  type    = "A"
  content = module.plantuml_server.vps_ipv4

  ttl     = 1
  proxied = true
}
