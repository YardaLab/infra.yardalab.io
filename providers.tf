# ──────────────────────────────────────────────────────────────
# File: providers.tf
# Purpose: Define all available providers used in the infrastructure.
# Supports Linode, AWS, GCP, and Local environments.
# Author: YardaLab Infrastructure Team
# ──────────────────────────────────────────────────────────────

terraform {
  required_version = ">= 1.9.0"

  required_providers {
    linode = {
      source  = "linode/linode"
      version = ">= 2.0.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }

    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }

    local = {
      source  = "hashicorp/local"
      version = ">= 2.5"
    }

    null = {
      source  = "hashicorp/null"
      version = ">= 3.2"
    }
  }
}

# ----------------------------------------------------------------------------- 
# Linode Provider
# Used for cloud deployments of lightweight services (default target).
# -----------------------------------------------------------------------------

provider "linode" {
  token = var.linode_token
}

# ----------------------------------------------------------------------------- 
# AWS Provider
# Used for scalable deployments or integrations with AWS services.
# -----------------------------------------------------------------------------

provider "aws" {
  region = var.region
  # profile = "default"  # uncomment if you use named AWS CLI profile
}

# ----------------------------------------------------------------------------- 
# Google Cloud Provider
# Used for container or AI-related workloads in GCP.
# -----------------------------------------------------------------------------

provider "google" {
  project = var.gcp_project
  region  = var.region
}

# ----------------------------------------------------------------------------- 
# Local Provider
# Used for on-premise environments (e.g., Raspberry Pi, Dell server).
# -----------------------------------------------------------------------------

provider "local" {}

# ----------------------------------------------------------------------------- 
# Null Provider
# Used for utility resources (placeholders, triggers, etc.).
# -----------------------------------------------------------------------------

provider "null" {}

# ----------------------------------------------------------------------------- 
# End of file
# -----------------------------------------------------------------------------
