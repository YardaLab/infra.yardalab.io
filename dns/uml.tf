resource "cloudflare_record" "uml" {
  zone_id = var.cloudflare_zone_id
  name    = "uml"
  type    = "A"

  content = var.plantuml_ip

  ttl     = 1
  proxied = false
}
