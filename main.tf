# ----------------------------------------------------------------------------- 
# Global locals
# Centralized naming conventions and reusable constants.
# -----------------------------------------------------------------------------

locals {
  project_name  = var.project_name
  environment   = var.environment
  naming_prefix = "${local.project_name}-${local.environment}"
}

# ----------------------------------------------------------------------------- 
# Future module references
# -----------------------------------------------------------------------------
# Modules such as "plantuml_server" will be added in later tasks (e.g. IYI-15).
# For now, this file defines only the base Terraform layout.