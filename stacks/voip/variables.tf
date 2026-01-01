variable "linode_token" {
  description = "Linode API token"
  type        = string
  sensitive   = true
}

variable "name" {
  description = "Logical name of the VoIP server"
  type        = string
}

variable "environment" {
  description = "Deployment environment (prod, staging, dev)"
  type        = string
}

variable "region" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "image" {
  type = string
}

variable "hostname" {
  type = string
}

variable "enable_ipv6" {
  type    = bool
  default = true
}

variable "tags" {
  type    = list(string)
  default = []
}
