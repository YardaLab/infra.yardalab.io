# ──────────────────────────────────────────────────────────────
# File: backend.tf
# Purpose: Define Terraform Cloud backend configuration for state storage.
#
# Mode: VCS-driven workspaces (Terraform Cloud)
#
# Notes:
# - Workspace selection is handled by Terraform Cloud based on the
#   workspace-to-repository (and working directory) mapping.
# - This backend configuration is intentionally workspace-agnostic.
# - No workspace name or tags are hardcoded here.
# - Variables (var.*) cannot be used in backend configuration.
#
# Author: YardaLab Infrastructure Team
# Updated: 2025-12-23
# ──────────────────────────────────────────────────────────────

terraform {
  required_version = ">= 1.9.8"

  # ---------------------------------------------------------------------------
  # Terraform Cloud Backend (VCS-driven)
  # ---------------------------------------------------------------------------
  # This repository uses Terraform Cloud for remote state management.
  #
  # Workspaces are defined and managed directly in Terraform Cloud and are
  # connected to this repository via VCS integration. Each workspace controls:
  #
  # - which branch is used
  # - which working directory is executed
  # - which variables and secrets are applied
  #
  # The active workspace is determined by Terraform Cloud at runtime.
  # No workspace selection logic exists in this repository.
  # ---------------------------------------------------------------------------

  cloud {
    organization = "YardaLab"
  }
}
