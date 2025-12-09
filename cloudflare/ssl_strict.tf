terraform {
  required_version = ">= 1.4.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 4.0"
    }
  }
}

data "cloudflare_zone" "yardalab" {
  name = "yardalab.io"
}

resource "cloudflare_zone_settings_override" "yardalab_ssl_strict" {
  zone_id = data.cloudflare_zone.yardalab.id

  settings {
    ssl = "strict"
  }
}
