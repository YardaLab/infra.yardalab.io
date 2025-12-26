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
