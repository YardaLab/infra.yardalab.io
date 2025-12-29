variable "region" {
  type        = string
  description = "Linode region"
}

variable "instance_type" {
  type        = string
  description = "Linode instance type"
}

variable "root_password" {
  type      = string
  sensitive = true
}

variable "internal_port" {
  type    = number
  default = 8080
}

variable "domain" {
  type        = string
  description = "Public domain for PlantUML (e.g. uml.yardalab.io)"
}

variable "linode_token" {
  description = "Linode API token used for authentication."
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token"
  type        = string
  sensitive   = true
}
