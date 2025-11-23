variable "label" {
  type = string
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

variable "ssh_keys" {
  type    = list(string)
  default = []
}

variable "root_pass" {
  type      = string
  default   = null
  sensitive = true
}

variable "tags" {
  type    = list(string)
  default = []
}

variable "backups_enabled" {
  type    = bool
  default = false
}

variable "private_ip" {
  type    = bool
  default = false
}
