resource "cloudflare_record" "test" {
  zone_id = var.cloudflare_zone_id
  name    = "tf-test"
  content = "1.1.1.1"
  type    = "A"
  ttl     = 120
}
