# voip-server Terraform Module

Terraform module for provisioning a generic Linode virtual machine intended
to run a VoIP / PBX workload.

This module is **infrastructure-only**. It creates a Linode instance with
a stable, well-defined input interface and exposes basic outputs required
by higher-level infrastructure layers.

Provisioning, application setup, and configuration management are intentionally
out of scope.

---

## Purpose & Responsibilities

This module is responsible for:

* Creating a Linode VM instance
* Applying basic instance configuration (region, type, image)
* Attaching optional features such as:

  * IPv6
  * SSH keys
  * cloud-init (user-data hook)

This module **does not**:

* Install or configure applications (Asterisk, FreePBX, etc.)
* Contain environment-specific logic
* Manage secrets beyond instance-level requirements
* Perform provisioning or post-boot configuration

---

## Environments

This module supports **multiple deployment environments** (for example `dev`, `staging`, `prod`) **without any code changes**.

### Environment selection

The active environment is selected **outside of the module**, typically via:

* **Terraform Cloud workspaces** (recommended)
* or environment-specific `*.tfvars` files (local / reference use)

The module itself remains environment-agnostic and relies solely on input variables.

### `environment` variable

The required `environment` variable identifies the target deployment environment:

```hcl
environment = "dev" | "staging" | "prod"
```

This variable is intended for:

* consistent environment identification
* naming and tagging at higher infrastructure layers
* documentation and audit clarity

> The module does not hardcode any environment-specific behavior.

---

## Variable types

### Non-sensitive variables

Non-sensitive variables are defined in `variables.tf` and may differ per environment:

* `environment`
* `region`
* `instance_type`
* `image`
* `hostname`
* `tags`
* `enable_ipv6`
* `ssh_keys`

These values are typically set:

* per Terraform Cloud workspace, or
* via `*.tfvars` files for local usage

### Sensitive variables

Sensitive values **must not** be committed to the repository.

The following inputs are marked as sensitive and are expected to be provided securely:

* `root_password`

When using Terraform Cloud, sensitive variables should be stored as **Sensitive Variables** in the workspace.

---

## Example Usage

```hcl
module "voip_server" {
  source = "../../modules/voip-server"

  environment   = "prod"
  name          = "voip-prod"
  region        = "eu-central"
  instance_type = "g6-standard-1"
  image         = "linode/ubuntu22.04"

  enable_ipv6 = true
  tags        = ["voip", "production"]

  cloud_init_template = file("${path.module}/cloud-init.yaml")
}
```

Cloud-init is optional. If not provided, the instance will boot without any
user-data.

---

## Inputs

| Name                  | Type           | Required | Description                                  |
| --------------------- | -------------- | -------- | -------------------------------------------- |
| `environment`         | `string`       | yes      | Deployment environment (`dev`, `staging`, `prod`) |
| `name`                | `string`       | yes      | Linode instance label (visible in Linode UI) |
| `region`              | `string`       | yes      | Linode region (e.g. `eu-central`)            |
| `instance_type`       | `string`       | yes      | Linode instance type                         |
| `image`               | `string`       | yes      | Linode image (e.g. `linode/ubuntu22.04`)     |
| `hostname`            | `string`       | no       | Hostname assigned to the instance            |
| `tags`                | `list(string)` | no       | Tags applied to the instance                 |
| `enable_ipv6`         | `bool`         | no       | Enable IPv6 networking                       |
| `ssh_keys`            | `list(string)` | no       | SSH public keys allowed to access the server |
| `root_password`       | `string`       | no       | Root password (may be null)                  |
| `cloud_init_template` | `string`       | no       | Optional cloud-init / user-data content      |

---

## Outputs

| Name           | Description                       |
| -------------- | --------------------------------- |
| `id`           | Linode instance ID                |
| `ipv4_address` | Primary IPv4 address              |
| `ipv6_address` | Primary IPv6 address (if enabled) |
| `status`       | Instance status                   |

---

## Notes & Limitations

* Cloud-init support is optional and disabled by default
* Cloud-init content is passed as-is via Linode instance metadata
* This module is designed to be reusable across environments
* Application provisioning must be handled by a separate layer
  (for example cloud-init templates, Ansible, or custom images)

---

## Related Work

* IYI-36 — VoIP server module
* IYI-49 — Cloud-init support
* IYI-39 — Cloud-init provisioning (planned)

---

## Requirements

* Terraform `>= 1.5.0`
* Linode provider configured by the calling stack
