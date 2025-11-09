# VPS Module (v1)

The **VPS module** provisions a virtual private server with consistent parameters across providers.  
Version **v1** currently implements the **Linode** provider and serves as the base layer for all infrastructure modules (e.g., `plantuml_server`, `ylcore_backend`, etc.).

---

## Overview

| Feature | Description |
|----------|--------------|
| Provider | `linode/linode` (v3.5.0+) |
| Purpose  | Creates and manages a single VPS instance |
| Module Path | `modules/vps` |
| Tested Example | `examples/vps_linode` |
| Backend | HCP Terraform (`infra` workspace) |

---

## Inputs

| Name | Type | Default | Description |
|------|------|----------|--------------|
| `provider` | `string` | `"linode"` | Cloud provider. Currently only `linode` supported. |
| `label` | `string` | — | Instance label (unique per account). |
| `region` | `string` | — | Region identifier, e.g., `eu-central`. |
| `instance_type` | `string` | — | Instance plan (e.g., `g6-nanode-1`). |
| `image` | `string` | — | OS image (e.g., `linode/ubuntu24.04`). |
| `ssh_keys` | `list(string)` | `[]` | List of authorized SSH public keys. |
| `root_pass` | `string` | `null` | Optional root password (sensitive). |
| `tags` | `list(string)` | `[]` | Tags for grouping or identification. |
| `backups_enabled` | `bool` | `false` | Enables Linode backups. |
| `private_ip` | `bool` | `false` | Enables private IP (if region supports it). |

---

## Outputs

| Name | Description |
|------|--------------|
| `id` | Instance ID. |
| `ip_address` | Primary IPv4 address of the instance. |
| `status` | Current instance status. |

---

## Example Usage

```hcl
provider "linode" {
  token = var.linode_token
}

module "vps" {
  source          = "../../modules/vps"
  label           = "ylcore-dev-01"
  region          = "eu-central"
  instance_type   = "g6-nanode-1"
  image           = "linode/ubuntu24.04"
  ssh_keys        = ["ssh-ed25519 AAAA... user@host"]
  backups_enabled = false
  private_ip      = false
  tags            = ["yl", "env:dev", "app:ylcore"]
}
