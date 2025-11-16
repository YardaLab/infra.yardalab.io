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