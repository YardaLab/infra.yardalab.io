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
