terraform {
  required_version = ">= 1.4.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 3.0.2"
    }
  }
}

# Pull image
resource "docker_image" "plantuml" {
  name         = var.image
  keep_locally = true
}

# Persistent tmp volume for Jetty (optional but helps avoid Linode churn)
resource "docker_volume" "jetty_tmp" {
  name = "${var.name}-jetty-tmp"

  dynamic "labels" {
    for_each = merge({
      "com.yardalab.service" = var.name
    }, var.labels)
    content {
      label = labels.key
      value = labels.value
    }
  }
}

# Container
resource "docker_container" "plantuml" {
  name  = var.name
  image = docker_image.plantuml.image_id

  ports {
    internal = var.container_port
    external = var.host_port
    ip       = var.host_ip
    protocol = "tcp"
  }

  mounts {
    target    = "/var/lib/jetty/tmp"
    type      = "volume"
    source    = docker_volume.jetty_tmp.name
    read_only = false
  }

  restart = var.restart_policy

  env = compact([
    "PLANTUML_THEME=${var.theme}",
    var.domain != null ? "VIRTUAL_HOST=${var.domain}" : "",
    var.ssl_enabled ? "SSL_ENABLED=1" : "SSL_ENABLED=0",
  ])

  memory      = 0
  memory_swap = 0

  dynamic "labels" {
    for_each = merge({
      "com.yardalab.role"    = "doc-renderer",
      "com.yardalab.module"  = "plantuml-server",
      "com.yardalab.exposed" = "http:${var.host_ip}:${var.host_port}"
    }, var.labels)
    content {
      label = labels.key
      value = labels.value
    }
  }
}
