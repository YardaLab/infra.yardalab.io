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
