############################################
# Variables – VoIP Server (Linode)
# File: modules/voip-server/variables.tf
############################################

variable "name" {
  description = "Linode instance name"
  type        = string
}

variable "region" {
  description = "Linode region"
  type        = string
}

variable "instance_type" {
  description = "Linode instance type (e.g. g6-nanode-1)"
  type        = string
}

variable "image" {
  description = "Linode image (e.g. linode/ubuntu22.04)"
  type        = string
}

variable "tags" {
  description = "Tags applied to the Linode instance"
  type        = list(string)
  default     = []
}

############################################
# SSH access
############################################

variable "ssh_public_key" {
  description = "Public SSH key injected into the root account via Linode SSH key"
  type        = string
}

############################################
# Firewall-related variables
############################################

variable "ssh_source_cidrs" {
  description = "Allowed CIDRs for SSH access"
  type        = list(string)
}

variable "sip_ports" {
  description = "List of SIP ports with protocol"
  type = list(object({
    port     = number
    protocol = string
  }))
}

variable "sip_source_cidrs" {
  description = "Allowed CIDRs for SIP signaling"
  type        = list(string)
}

variable "rtp_port_range" {
  description = "RTP port range configuration"
  type = object({
    from     = number
    to       = number
    protocol = string
  })
}

variable "allow_rtp_from_any" {
  description = "Allow RTP from 0.0.0.0/0"
  type        = bool
  default     = false
}

variable "rtp_source_cidrs" {
  description = "Allowed CIDRs for RTP media traffic"
  type        = list(string)
}
