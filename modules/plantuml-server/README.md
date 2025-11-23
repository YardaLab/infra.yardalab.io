# PlantUML Server Terraform Module

This Terraform module deploys a containerized **PlantUML server** instance, providing diagram rendering capabilities for the YardaLab infrastructure.

The module is designed to be reusable across environments and supports optional configuration such as theming, domain assignment, and SSL enablement.

---

## Features

* Deploys an isolated PlantUML container
* Supports pluggable rendering themes (`theme` variable)
* Optional domain configuration (future use for reverse proxy)
* Optional SSL flag (future use for reverse proxy)
* Compatible with Docker-based Terraform providers
* Example usage included in `examples/plantuml-server/`

---

## Inputs

| Name          | Type   | Default     | Description                                                                      |
| ------------- | ------ | ----------- | -------------------------------------------------------------------------------- |
| `domain`      | string | `null`      | Optional custom domain for the PlantUML server. Used later by the reverse proxy. |
| `ssl_enabled` | bool   | `false`     | Enables or disables SSL termination at the reverse proxy layer.                  |
| `theme`       | string | `"default"` | Rendering theme used by PlantUML (`PLANTUML_THEME`).                             |

---

## Outputs

| Name          | Description                        |
| ------------- | ---------------------------------- |
| `domain`      | The domain passed into the module. |
| `ssl_enabled` | Whether SSL is enabled.            |
| `theme`       | Selected PlantUML theme.           |

---

## Example Usage

```hcl
module "plantuml_server" {
  source = "../../modules/plantuml-server"

  domain      = "uml.example.com"
  ssl_enabled = true
  theme       = "yl-dark"
}
```

This example is also available inside:

```
examples/plantuml-server/
```

---

## Notes

* This module **does not include a reverse proxy**.
  Variables `domain` and `ssl_enabled` are placeholders for future integration (e.g., Traefik, NGINX, or Caddy).
* PlantUML server is accessible on an internal Docker network unless exposed through a reverse proxy or port binding.

---

## Maintainer

**YardaLab s.r.o.**
Module author: Jaroslav Miczka
Contact: [jarda@yardalab.io](mailto:jarda@yardalab.io)
