# ──────────────────────────────────────────────────────────────
# File: backend.tf
# Purpose: Define Terraform backend configuration for state storage.
# Note:
#   Variables (var.*) cannot be used in backend configuration.
#   Environment-specific settings can be added later via
#   -backend-config files (e.g., dev.backend.hcl, prod.backend.hcl).
# Author: YardaLab Infrastructure Team
# Updated: 2025-11-06
# ──────────────────────────────────────────────────────────────

terraform {
  required_version = ">= 1.9.8"

  # ---------------------------------------------------------------------------
  # Backend Configuration
  # ---------------------------------------------------------------------------
  # This backend defines how Terraform stores and manages its state file.
  # The project now uses a REMOTE backend via Terraform Cloud (CLI-driven mode)
  # to ensure centralized, consistent, and secure state management.
  #
  # Each Terraform operation (init, plan, apply) will authenticate through
  # Terraform Cloud using your personal TF_API_TOKEN credentials.
  #
  # Workspace:
  #   Organization: YardaLab
  #   Workspace:    infra
  #
  # This configuration allows multiple contributors or CI/CD pipelines
  # to share a single state file with remote locking and version history.
  # ---------------------------------------------------------------------------

  cloud {
    organization = "YardaLab"

    workspaces {
      name = "infra"
    }
  }
}
