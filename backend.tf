# ──────────────────────────────────────────────────────────────
# File: backend.tf
# Purpose: Define Terraform backend configuration for state storage.
# Note:
#   Variables (var.*) cannot be used in backend configuration.
#   Environment-specific settings will be added later via
#   -backend-config files (e.g., dev.backend.hcl, prod.backend.hcl).
# Author: YardaLab Infrastructure Team
# ──────────────────────────────────────────────────────────────

terraform {
  required_version = ">= 1.9.0"

  # ---------------------------------------------------------------------------
  # Backend Configuration
  # ---------------------------------------------------------------------------
  # This backend defines how Terraform stores and manages its state file.
  # Currently, the project uses a LOCAL backend for simplicity and portability.
  #
  # The state file (terraform.tfstate) is stored locally within the repository.
  # This configuration is suitable for initial setup, prototyping, or
  # Codespaces development environments.
  #
  # Future environments (e.g., Linode Object Storage, GCS, or Terraform Cloud)
  # will override this using -backend-config files for centralized state
  # management and remote locking.
  # ---------------------------------------------------------------------------

  backend "local" {
    path = "terraform.tfstate"
  }
}
