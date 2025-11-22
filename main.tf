# ──────────────────────────────────────────────────────────────
# File: main.tf
# Purpose: Root Terraform module for YardaLab infrastructure.
# This file defines global locals and loads all submodules
# (e.g., plantuml-server, database, networking, etc.).
# Author: YardaLab Infrastructure Team
# ──────────────────────────────────────────────────────────────


# ----------------------------------------------------------------------------- 
# Global locals
# Centralized naming conventions and reusable constants.
# These locals ensure consistent naming across the entire infrastructure.
# -----------------------------------------------------------------------------

locals {
  project_name = var.project_name
  environment  = var.environment

  # Example: yardalab-dev, yardalab-prod
  naming_prefix = "${local.project_name}-${local.environment}"
}


# ----------------------------------------------------------------------------- 
# PlantUML Server Module
# This module deploys a Linode VPS with Docker + PlantUML server.
# Added as part of task IYI-15 / IYI-20.
# -----------------------------------------------------------------------------

module "plantuml-server" {
  source = "./modules/plantuml-server"

  # Required inputs for server_url output
  domain        = var.domain
  ssl_enabled   = var.ssl_enabled
  theme         = var.theme
  external_port = var.external_port
}


# ----------------------------------------------------------------------------- 
# Future Modules Placeholder
# Additional modules will be added later, such as:
# - Authentication server
# - YLCore backend
# - Documentation renderer
# - Reverse proxy (NGINX)
# - Metrics / Monitoring stack
#
# These modules will follow the same structure and naming conventions.
# -----------------------------------------------------------------------------

# module "ylcore" {
#   source = "./modules/ylcore"
#   environment = var.environment
# }


# ----------------------------------------------------------------------------- 
# End of file
# -----------------------------------------------------------------------------
