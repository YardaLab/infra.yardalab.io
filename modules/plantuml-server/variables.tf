# ──────────────────────────────────────────────────────────────
# File: variables.tf
# Purpose: Input variables for plantuml-server module
# Cleaned & aligned with current module logic
# ──────────────────────────────────────────────────────────────

# -------------------------------------------------------------------
# Linode instance configuration
# -------------------------------------------------------------------

variable "region" {
  description = "Linode region where the PlantUML instance will run."
  type        = string
}

variable "instance_type" {
  description = "Linode instance type to use (e.g., g6-nanode-1)."
  type        = string
  default     = "g6-nanode-1"
}

variable "root_password" {
  description = "Root password for the Linode instance."
  type        = string
  sensitive   = true
}

# -------------------------------------------------------------------
# Networking & Ports
# -------------------------------------------------------------------

variable "internal_port" {
  description = "Internal port the PlantUML Jetty server listens on."
  type        = number
  default     = 8080
}

# -------------------------------------------------------------------
# Application settings
# -------------------------------------------------------------------

variable "domain" {
  description = "Optional domain for the PlantUML server. Not required when using IP-based access."
  type        = string
  default     = ""
}

variable "ssl_enabled" {
  description = "Enables HTTPS in server_url output (if domain is used behind SSL proxy)."
  type        = bool
  default     = false
}

variable "theme" {
  description = "PlantUML theme used during diagram rendering."
  type        = string
  default     = "default"
}

# -------------------------------------------------------------------
# End of file
# -------------------------------------------------------------------
