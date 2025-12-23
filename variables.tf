############################################
# File: variables.tf
# Scope: Root / global infrastructure variables
# Purpose: Environment-specific configuration
############################################

# --------------------------------------------------
# Environment
# --------------------------------------------------
variable "environment" {
  description = "The target deployment environment (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Logical name of the project or infrastructure stack."
  type        = string
  default     = "yardalab"
}

# --------------------------------------------------
# Region & provider configuration
# --------------------------------------------------
variable "region" {
  description = "Primary region for resource deployment."
  type        = string
  default     = "eu-central"
}

variable "linode_token" {
  description = "Linode API token used for authentication."
  type        = string
  sensitive   = true
}

# --------------------------------------------------
# Compute / instance configuration
# --------------------------------------------------
variable "instance_type" {
  description = "Linode instance type."
  type        = string
  default     = "g6-nanode-1"
}

variable "root_password" {
  description = "Root password for Linode instance."
  type        = string
  sensitive   = true
}

# --------------------------------------------------
# Networking / domain
# --------------------------------------------------
variable "domain" {
  description = "Domain used for the service (e.g. plantuml.yardalab.io)."
  type        = string
  default     = "plantuml.yardalab.io"
}

variable "ssl_enabled" {
  description = "Enable HTTPS / SSL for the service."
  type        = bool
  default     = false
}

# --------------------------------------------------
# Optional / feature flags
# --------------------------------------------------
variable "theme" {
  description = "Theme identifier (used by some services like PlantUML)."
  type        = string
  default     = "default"
}

variable "gcp_project" {
  description = "Google Cloud project ID (optional, provider-specific)."
  type        = string
  default     = ""
}

# --------------------------------------------------
# Cloudflare
# --------------------------------------------------
variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID for yardalab.io"
  type        = string
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token used to manage DNS for yardalab.io"
  type        = string
  sensitive   = true
}
