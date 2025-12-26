# ──────────────────────────────────────────────────────────────
# Stack: PlantUML
# Purpose: Deploy a PlantUML server using the reusable module
# Workspace: infra-plantuml
# ──────────────────────────────────────────────────────────────

module "plantuml_server" {
  source = "../../modules/plantuml-server"

  # Infrastructure parameters
  region        = var.region
  instance_type = var.instance_type

  # Runtime / bootstrap parameters
  internal_port = var.internal_port
  root_password = var.root_password

  # Public domain (used by Caddy inside the module)
  domain = var.domain
}
