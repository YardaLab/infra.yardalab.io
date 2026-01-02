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

# tflint-ignore: terraform_unused_declarations
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

# tflint-ignore: terraform_unused_declarations
variable "name" {
  description = "Linode instance label (resource name visible in Linode UI)."
  type        = string
}

# tflint-ignore: terraform_unused_declarations
variable "region" {
  description = "Linode region where the VoIP server will be deployed (e.g. eu-central)."
  type        = string
}

# tflint-ignore: terraform_unused_declarations
variable "instance_type" {
  description = "Linode instance type (e.g. g6-nanode-1, g6-standard-1)."
  type        = string
}

# tflint-ignore: terraform_unused_declarations
variable "image" {
  description = "Linode image to use for the instance (e.g. linode/ubuntu22.04)."
  type        = string
}

############################################
# Optional variables
############################################

# tflint-ignore: terraform_unused_declarations
variable "hostname" {
  description = "Hostname assigned to the VoIP server."
  type        = string
  default     = null
}

# tflint-ignore: terraform_unused_declarations
variable "tags" {
  description = "List of tags assigned to the Linode instance."
  type        = list(string)
  default     = []
}

# tflint-ignore: terraform_unused_declarations
variable "enable_ipv6" {
  description = "Whether IPv6 should be enabled for the instance."
  type        = bool
  default     = false
}

# tflint-ignore: terraform_unused_declarations
variable "ssh_keys" {
  description = "List of SSH public keys allowed to access the server."
  type        = list(string)
  default     = []
}

# tflint-ignore: terraform_unused_declarations
variable "root_password" {
  description = "Root password for the instance. If null, password authentication may be disabled."
  type        = string
  default     = null
  sensitive   = true
}

############################################
# Cloud-init (optional)
############################################

# tflint-ignore: terraform_unused_declarations
variable "cloud_init_template" {
  description = <<EOT
Optional cloud-init / user-data content.

This module does not define or manage any provisioning logic.
The content is passed as-is to the Linode instance.
If null, cloud-init is disabled.
EOT

  type    = string
  default = null
}

############################################
# VoIP firewall – SIP / RTP specification
############################################

# tflint-ignore: terraform_unused_declarations
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

# tflint-ignore: terraform_unused_declarations
variable "sip_source_cidrs" {
  description = <<EOT
Allowed source CIDR ranges for SIP signaling traffic.

This should ideally contain SIP trunk / SBC provider IP ranges
(e.g. O2 SIP trunk).

If empty, the firewall implementation must treat this as
"provider allowlist pending" and handle it explicitly.
EOT

  type    = list(string)
  default = []
}

# tflint-ignore: terraform_unused_declarations
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

# tflint-ignore: terraform_unused_declarations
variable "rtp_source_cidrs" {
  description = <<EOT
Allowed source CIDR ranges for RTP media traffic.

By default, RTP is temporarily allowed from any source
to enable initial call testing before provider IP ranges
are confirmed.

This MUST be restricted in production once provider
media IP ranges are known.
EOT

  type    = list(string)
  default = ["0.0.0.0/0"]
}
