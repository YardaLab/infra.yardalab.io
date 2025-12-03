# ──────────────────────────────────────────────────────────────
# File: outputs.tf
# Purpose: Define output values exported from the root module.
# Outputs are used by other modules or CI/CD pipelines.
# Author: YardaLab Infrastructure Team
# ──────────────────────────────────────────────────────────────

# -----------------------------------------------------------------------------
# Global Outputs
# These outputs expose key information about the environment and resources.
# -----------------------------------------------------------------------------

output "environment" {
  description = "The current Terraform workspace environment."
  value       = var.environment
}

output "region" {
  description = "The region used for deployment."
  value       = var.region
}

output "naming_prefix" {
  description = "Global naming prefix used for resource naming consistency."
  value       = local.naming_prefix
}

output "server_url" {
  description = "URL of the PlantUML server returned from the module."
  value       = module.plantuml-server.server_url
}

output "cloudflare_zone_id" {
  description = "Zone ID used for Cloudflare resources"
  value       = var.cloudflare_zone_id
}

# -----------------------------------------------------------------------------
# Module Outputs
# Collect important values from submodules (e.g., endpoints, IDs, IPs).
# -----------------------------------------------------------------------------

# Example: PlantUML server public endpoint
# output "plantuml_server_endpoint" {
#   description = "Public URL of the deployed PlantUML server."
#   value       = module.plantuml_server.endpoint_url
# }

# -----------------------------------------------------------------------------
# End of file
# -----------------------------------------------------------------------------
