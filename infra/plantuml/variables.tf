variable "linode_token" {
  description = "Linode API token for provisioning."
  type        = string
  sensitive   = true
}

variable "root_password" {
  description = "Root password for the VPS."
  type        = string
  sensitive   = true
}
