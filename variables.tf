# environment, region, linode_token, root_password, project_name
variable "environment" {
  description = "The target deployment environment (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "region" {
  description = "Primary region for resource deployment."
  type        = string
  default     = "eu-central-1"
}

variable "linode_token" {
  description = "Linode API token used for authentication."
  type        = string
  sensitive   = true
}

variable "project_name" {
  description = "Logical name of the project or infrastructure stack."
  type        = string
  default     = "yardalab"
}

variable "gcp_project" {
  description = "Google Cloud project ID (used by the google provider)."
  type        = string
  default     = ""
}

variable "domain" {
  description = "Domain used for the PlantUML server."
  type        = string
  default     = "plantuml.yardalab.io"
}

variable "ssl_enabled" {
  description = "Enable HTTPS for the PlantUML server."
  type        = bool
  default     = false
}

variable "theme" {
  description = "Theme for the PlantUML server."
  type        = string
  default     = "default"
}

variable "external_port" {
  description = "External port exposed for the PlantUML server."
  type        = number
  default     = 8080
}

