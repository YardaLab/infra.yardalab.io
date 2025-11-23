# PlantUML Server Deployment (Terraform Remote Backend)

This document describes how to deploy the PlantUML server using **Terraform + HCP Terraform (remote backend)**.

The deployment provisions:

* Linode VPS
* Docker installation via StackScript
* Automatic startup of `plantuml/plantuml-server:jetty`

---

## Prerequisites

* Valid **Linode API token** stored as a sensitive variable in HCP Terraform
* Remote workspace configured to track directory `infra/plantuml`
* Variables defined in workspace:

  * `linode_token` (sensitive)
  * `root_password` (sensitive)

---

## Files Overview

### `infra/plantuml/main.tf`

Contains:

* StackScript resource
* Linode VPS instance using the StackScript
* Outputs for `vps_ip` and `plantuml_url`

### `infra/plantuml/versions.tf`

Defines:

* Terraform version
* Required providers
* Remote backend configuration (HCP Terraform)

### `infra/plantuml/outputs.tf`

Human‑friendly URLs and IP

---

## How to Deploy (Remote Execution)

Since this workspace uses **Terraform Cloud remote backend**, all plans and applies run on HCP Terraform.

### 1. Initialize

```bash
terraform init
```

### 2. Review infrastructure changes

```bash
terraform plan
```

This runs the plan in HCP Terraform.

### 3. Deploy VPS + StackScript + PlantUML container

```bash
terraform apply -auto-approve
```

This triggers remote apply.

### 4. Verify the PlantUML server

Replace `<vps_ip>` with the output from Terraform.

```bash
curl -s -o /dev/null -w "%{http_code}\n" http://<vps_ip>:8080/svg
```

Expected output:

```
200
```

---

## Destroying Infrastructure

```bash
terraform destroy
```

This destroys both:

* The Linode VPS
* The StackScript

---

## Useful Notes

* `terraform plan -out=plan.tfplan` **is not supported** with remote backends
* All `plan` and `apply` operations run on Terraform Cloud automatically
* StackScript installs Docker and runs PlantUML reliably using a shell script

---

## Example Output

After successful deployment, Terraform prints something like:

```
vps_ip       = "139.162.xxx.xxx"
plantuml_url = "http://139.162.xxx.xxx:8080/svg"
```

You can now integrate this endpoint into:

* docs.yardalab.io
* CI pipelines
* Internal tooling

---

Version: 1.0
Maintainer: YardaLab Infrastructure Team