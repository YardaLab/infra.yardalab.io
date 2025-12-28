# infra.yardalab.io

Infrastructure as Code for the **YardaLab ecosystem**.

This repository contains Terraform configurations, reusable infrastructure modules, and root stack definitions used to provision and operate YardaLab services using a **stack-based Terraform architecture**.

At present, the infrastructure is primarily used to deploy and maintain:

* **PlantUML server** available at [`plantuml.yardalab.io`](https://plantuml.yardalab.io)
* **Foundational infrastructure components** intended for future services (for example, VoIP / PBX)

---

## Purpose

This repository serves as the **single source of truth** for all YardaLab infrastructure.

Its goals are to:

* Provide a **clear, auditable infrastructure model**
* Enable **independent lifecycle management** of individual services
* Encourage reuse through **well-defined and composable Terraform modules**
* Support long-term growth without coupling unrelated services

Infrastructure is intentionally organized into **independent Terraform stacks**, each with its own state and execution context.

---

## Architecture model

YardaLab infrastructure follows a **stack-based Terraform architecture**:

* Each service (for example, PlantUML or VoIP) is represented by its **own root stack**
* Each stack has:

  * an isolated Terraform state
  * a dedicated Terraform Cloud workspace
  * an independent lifecycle (`plan`, `apply`, `destroy`)
* Shared logic is implemented exclusively through reusable Terraform modules

This model reduces blast radius, simplifies auditing and rollbacks, and enables safe expansion as additional services are introduced.

---

## Repository structure

```
infra.yardalab.io/
├── stacks/               # Root Terraform stacks (one per service)
│   ├── plantuml/         # PlantUML infrastructure stack
│   └── voip/             # VoIP / PBX infrastructure stack (foundation)
├── modules/              # Reusable Terraform modules
├── .devcontainer/        # Development environment for GitHub Codespaces
├── .github/workflows/    # GitHub Actions for CI/CD
├── LICENSE               # Apache 2.0 license
├── CONTRIBUTING.md       # Contribution guidelines
└── README.md             # Repository documentation
```

---

## Terraform usage and workflow

### Stack-based workflow

Each directory under `stacks/` is a **standalone Terraform root module**.

Typical workflow:

```bash
cd stacks/<stack-name>
terraform init
terraform plan
terraform apply
```

Stacks are designed to be planned, applied, and destroyed independently of one another.

---

### Terraform Cloud

Terraform state is managed using **Terraform Cloud**.

* Each stack maps to a **dedicated Terraform Cloud workspace**
* Workspace configuration points to the corresponding `stacks/<name>` directory
* Sensitive values (such as tokens or passwords) are stored as Terraform Cloud variables

This approach provides secure secret handling, auditable state history, and reproducible deployments.

---

### Module versioning

Terraform modules are consumed via **immutable Git references (tags)**.

This ensures:

* reproducible and deterministic plans
* protection against deleted or rebased branches
* predictable infrastructure behavior during reviews and audits

Example module source reference:

```hcl
source = "git::https://github.com/YardaLab/infra.yardalab.io.git//modules/plantuml-server?ref=<tag>"
```

---

## Development workflow

All changes to this repository follow a controlled development workflow.

### Branching strategy

Each change is implemented on a dedicated branch:

```
feature/<short-description>
```

Branches are short-lived and represent a single logical change.

### Commits and pull requests

* Commits should be atomic and descriptive
* All changes are merged into `main` via pull requests
* Branches are automatically deleted after merge

This workflow ensures traceability, reviewability, and long-term maintainability of the infrastructure codebase.

For detailed contribution rules, see [`CONTRIBUTING.md`](./CONTRIBUTING.md).

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
