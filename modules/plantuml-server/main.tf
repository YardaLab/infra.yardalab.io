# ──────────────────────────────────────────────────────────────
# File: main.tf
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

# -------------------------------------------------------------------
# StackScript: Install Docker + PlantUML on Linode
# -------------------------------------------------------------------
resource "linode_stackscript" "plantuml" {
  label       = "plantuml-bootstrap"
  description = "Install Docker and run PlantUML server."
  images      = ["linode/ubuntu22.04"]
  is_public   = false

  script = <<-EOT
    #!/bin/bash
    set -eux

    apt-get update -y

    # Install Docker
    DEBIAN_FRONTEND=noninteractive \
      apt-get install -y docker.io

    systemctl enable docker
    systemctl start docker

    # Run PlantUML server
    docker run -d \
      --restart=always \
      -p ${var.internal_port}:${var.internal_port} \
      plantuml/plantuml-server:jetty
  EOT
}

# -------------------------------------------------------------------
# Linode instance running PlantUML
# -------------------------------------------------------------------
resource "linode_instance" "plantuml" {
  label     = "plantuml-server"
  image     = "linode/ubuntu22.04"
  region    = var.region
  type      = var.instance_type
  root_pass = var.root_password

  stackscript_id = linode_stackscript.plantuml.id
}
