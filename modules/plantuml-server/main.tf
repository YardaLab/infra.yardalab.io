# ──────────────────────────────────────────────────────────────
# File: modules/plantuml-server/main.tf
# Purpose: Deploy PlantUML server on Linode using StackScript
# Author: YardaLab Infrastructure Team
# ──────────────────────────────────────────────────────────────

terraform {
  required_version = ">= 1.4.0"

  required_providers {
    linode = {
      source  = "linode/linode"
      version = ">= 3.5.0"
    }
  }
}

resource "linode_stackscript" "plantuml" {
  label       = "yl-plantuml-bootstrap"
  description = "Install Docker, PlantUML server, and Caddy reverse proxy."
  images      = ["linode/ubuntu22.04"]
  is_public   = false

  script = <<-EOT
    #!/bin/bash
    set -eux

    apt-get update -y

    # --------------------------------------------------------
    # Install Docker
    # --------------------------------------------------------
    DEBIAN_FRONTEND=noninteractive \
      apt-get install -y docker.io

    systemctl enable docker
    systemctl start docker

    # --------------------------------------------------------
    # Run PlantUML Docker container
    # --------------------------------------------------------
    docker run -d \
      --restart=always \
      -p ${var.internal_port}:${var.internal_port} \
      plantuml/plantuml-server:jetty

    # --------------------------------------------------------
    # Install Caddy (official repo)
    # --------------------------------------------------------
    apt install -y debian-keyring debian-archive-keyring curl gnupg
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' \
      | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg

    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' \
      | tee /etc/apt/sources.list.d/caddy-stable.list

    apt update -y
    apt install -y caddy

    # --------------------------------------------------------
    # Create Caddyfile (reverse proxy + HTTPS)
    # --------------------------------------------------------
    cat <<EOF >/etc/caddy/Caddyfile
    uml.yardalab.io {
        reverse_proxy localhost:${var.internal_port}

        header {
            Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
            X-Content-Type-Options "nosniff"
            X-Frame-Options "DENY"
            Referrer-Policy "no-referrer"
        }
    }
    EOF

    # --------------------------------------------------------
    # Restart Caddy to apply config
    # --------------------------------------------------------
    systemctl enable caddy
    systemctl restart caddy

  EOT
}

# ------------------------------------------------------------
# Linode Instance for PlantUML + Caddy
# ------------------------------------------------------------
resource "linode_instance" "plantuml" {
  label     = "yl-plantuml-server"
  image     = "linode/ubuntu22.04"
  region    = var.region
  type      = var.instance_type
  root_pass = var.root_password

  stackscript_id = linode_stackscript.plantuml.id
}
