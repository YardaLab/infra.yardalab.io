variable "name" {
  description = "Container name"
  type        = string
  default     = "plantuml-server"
}


variable "image" {
  description = "Docker image"
  type        = string
  default     = "plantuml/plantuml-server:jetty"
}


variable "host_ip" {
  description = "Host IP to bind container's HTTP port (use 127.0.0.1 to keep internal)"
  type        = string
  default     = "127.0.0.1"
}


variable "host_port" {
  description = "Host port for HTTP"
  type        = number
  default     = 8080
}


variable "container_port" {
  description = "Container HTTP port"
  type        = number
  default     = 8080
}


variable "labels" {
  description = "Extra docker labels"
  type        = map(string)
  default     = {}
}


variable "restart_policy" {
  description = "Docker restart policy"
  type        = string
  default     = "unless-stopped"
}

variable "domain" {
  type        = string
  description = "Optional custom domain for the PlantUML server."
  default     = null
}

variable "ssl_enabled" {
  type        = bool
  description = "Enable or disable SSL termination in the reverse proxy."
  default     = false
}

variable "theme" {
  type        = string
  description = "PlantUML rendering theme."
  default     = "default"
}

variable "external_port" {
  type        = number
  description = "External port used to expose the PlantUML server."
  default     = 80
}
