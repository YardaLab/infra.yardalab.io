# infra.yardalab.io

Infrastructure as Code for the YardaLab ecosystem.
This repository contains Terraform configurations, deployment scripts, and infrastructure modules used to provision and manage YardaLab services.

Currently, it is used to deploy and maintain the **PlantUML server** running at [`plantuml.yardalab.io`](https://plantuml.yardalab.io).

---

## Purpose

This repository serves as the central place for all infrastructure-related automation and provisioning.
It defines the infrastructure for internal YardaLab services, including:

* **PlantUML server** — containerized diagram rendering service
* **CI/CD pipelines** — for automatic updates and prebuilds
* **Terraform modules** — reusable building blocks for multi-environment setup

---

## Repository structure

```
infra.yardalab.io/
├── .devcontainer/        # Dev environment for GitHub Codespaces
├── terraform/            # Terraform modules and configuration
├── scripts/              # Deployment and maintenance scripts
├── .github/workflows/    # GitHub Actions for CI/CD
├── LICENSE               # Apache 2.0 license
├── CONTRIBUTING.md       # Contribution guidelines
└── README.md             # Project documentation
```

---

## Development workflow

All work on this repository is tracked via Jira issues under the **IYI** project key.
Each implementation task must be performed on a dedicated branch named after the Jira issue:

```
feature/IYI-<issue-number>-<short-description>
```

Commits must reference the Jira issue key in the message:

```
IYI-2: chore(repo): initialize infra repository
```

After all subtasks are completed and reviewed, the branch is merged into `main` via a pull request linked to the Jira ticket.

For more detailed contribution rules, see the [`CONTRIBUTING.md`](./CONTRIBUTING.md) file.

---

## Licensing

This repository is licensed under the **Apache License 2.0**.
See the [`LICENSE`](./LICENSE) file for details.

---

## Related repositories

* [`ylcore`](https://github.com/YardaLab/ylcore) — YardaLab Core backend
* [`docs.yardalab.io`](https://github.com/YardaLab/docs.yardalab.io) — documentation portal
* [`ylsdk`](https://github.com/YardaLab/ylsdk) — client SDK
* [`yldashboard`](https://github.com/YardaLab/yldashboard) — user dashboard

---

## Maintainer

**YardaLab s.r.o.**
Author: Jaroslav Miczka
Contact: [jarda@yardalab.io](mailto:jarda@yardalab.io)
