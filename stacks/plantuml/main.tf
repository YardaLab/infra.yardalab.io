# ──────────────────────────────────────────────────────────────
# Stack: PlantUML
# Purpose: Deploy a PlantUML server using the reusable module
# Workspace: infra-plantuml
# ──────────────────────────────────────────────────────────────

module "plantuml_server" {
  source = "git::https://github.com/YardaLab/infra.yardalab.io.git//modules/plantuml-server?ref=feature/IYI-37-create-linode-instance"

  region        = var.region
  instance_type = var.instance_type
  internal_port = var.internal_port
  root_password = var.root_password
  domain        = var.domain
}
