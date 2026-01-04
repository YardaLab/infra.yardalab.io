/**
 * voip-server module
 *
 * Public input interface.
 * This file defines the stable contract between the module
 * and its consumers. No implementation logic allowed here.
 */

############################################
# Environment
############################################

variable "environment" {
  description = "Deployment environment (dev, staging, prod)."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod"
  }
}

############################################
# Required variables
############################################

variable "name" {
  description = "Linode instance label (resource name visible in Linode UI)."
  type        = string
}

variable "region" {
  description = "Linode region where the VoIP server will be deployed (e.g. eu-central)."
  type        = string
}

variable "instance_type" {
  description = "Linode instance type (e.g. g6-nanode-1, g6-standard-1)."
  type        = string
}

variable "image" {
  description = "Linode image to use for the instance (e.g. linode/ubuntu22.04)."
  type        = string
}

############################################
# Optional variables
############################################

variable "hostname" {
  description = "Hostname assigned to the VoIP server."
  type        = string
  default     = null
}

variable "tags" {
  description = "List of tags assigned to the Linode instance."
  type        = list(string)
  default     = []
}

variable "enable_ipv6" {
  description = "Whether IPv6 should be enabled for the instance."
  type        = bool
  default     = false
}

############################################
# SSH access (DETERMINISTIC)
############################################

variable "ssh_public_keys" {
  description = "List of SSH public keys for initial ubuntu user login."
  type        = list(string)
}

############################################
# VoIP firewall – inbound specification
############################################

variable "ssh_source_cidrs" {
  description = <<EOT
Allowed source CIDR ranges for SSH access (TCP/22).

This MUST be restricted to administrator IPs or VPN ranges.
Inbound SSH access is never allowed from 0.0.0.0/0.
EOT

  type = list(string)
}

variable "sip_ports" {
  description = <<EOT
SIP signaling ports exposed by the VoIP server.

Default reflects standard Asterisk / FreePBX setup:
- UDP 5060 (SIP)

TLS (5061) is intentionally out of scope for now.
EOT

  type = list(object({
    protocol = string
    port     = number
  }))

  default = [
    {
      protocol = "udp"
      port     = 5060
    }
  ]
}

variable "sip_source_cidrs" {
  description = <<EOT
Allowed source CIDR ranges for SIP signaling traffic.

This should contain SIP trunk / SBC provider IP ranges
(e.g. O2 SIP trunk).

Empty list means provider allowlist is pending
and must be handled explicitly by firewall logic.
EOT

  type    = list(string)
  default = []
}

variable "rtp_port_range" {
  description = <<EOT
RTP media port range used for VoIP calls.

Default reflects Asterisk / FreePBX defaults.
EOT

  type = object({
    protocol = string
    from     = number
    to       = number
  })

  default = {
    protocol = "udp"
    from     = 10000
    to       = 20000
  }
}

variable "rtp_source_cidrs" {
  description = <<EOT
Allowed source CIDR ranges for RTP media traffic.

Used when allow_rtp_from_any = false.

In production, this MUST be restricted to provider media IP ranges.
EOT

  type    = list(string)
  default = []
}

variable "allow_rtp_from_any" {
  description = <<EOT
Temporary flag to allow RTP media traffic from any source (0.0.0.0/0).

This is intended ONLY for initial call testing.

It MUST be set to false in production environments.
EOT

  type    = bool
  default = true
}
