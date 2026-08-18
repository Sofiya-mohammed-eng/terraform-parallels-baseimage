# Terraform + Parallels Desktop Lab

Infrastructure-as-code lab for provisioning and tearing down local virtual machines
using Terraform, driven against a Parallels Desktop host via the
[Parallels DevOps Service](https://github.com/Parallels/prl-devops-service).

This project is part of a Linux SysAdmin / DevOps portfolio build, demonstrating
reproducible, declarative infrastructure management on a local hypervisor —
exploring how Terraform can drive real VM lifecycle management against Parallels Desktop.

## Architecture

Terraform CLI
  -> Parallels/parallels-desktop provider (community provider)
     authenticates via host + username/password per-resource
  -> prldevops (Parallels DevOps Service), local REST API on :8088
     wraps Vagrant to build/manage VMs
  -> Parallels Desktop, hypervisor on macOS (Apple Silicon)
  -> Ubuntu 22.04 LTS (arm64) VM, from the bento/ubuntu-22.04 Vagrant box

## What's here

- modules/ubuntu-vm/ — Reusable module: builds one Ubuntu VM from a Vagrant box
  - main.tf
  - variables.tf
  - outputs.tf
  - versions.tf
- web-server/ — First real deployment, calls the ubuntu-vm module
  - main.tf
  - variables.tf
  - terraform.tfvars.example
- README.md

Each server type (web, DNS, DHCP, etc.) lives in its own folder and simply calls
`modules/ubuntu-vm` with different inputs — no duplicated provider/resource logic.

## Prerequisites

- macOS with [Parallels Desktop](https://www.parallels.com/products/desktop/) (Pro/Business edition — required for the DevOps API and Vagrant provider)
- [Parallels DevOps Service](https://github.com/Parallels/prl-devops-service) (`prldevops`) installed and running locally
- [Terraform](https://developer.hashicorp.com/terraform/install) v1.15+
- [Vagrant](https://developer.hashicorp.com/vagrant/install) with the `vagrant-parallels` plugin (`vagrant plugin install vagrant-parallels`)
- A Parallels Desktop Pro/Business license key

## Setup

1. Copy the example variables file and fill in real values (never commit this file):

   cp terraform.tfvars.example web-server/terraform.tfvars

2. Ensure `prldevops` is running with the Vagrant plugin enabled
   (`ENABLE_VAGRANT_PLUGIN: "true"` in its config).

3. From a server folder, initialize and apply:

   cd web-server
   terraform init
   terraform plan
   terraform apply

4. Tear down when done:

   terraform destroy

## Milestone: first working end-to-end cycle

As of this commit, the full lifecycle has been verified on hardware:

- `terraform apply` builds a real Ubuntu 22.04 LTS (arm64) VM on the Mac Mini host
- VM confirmed reachable and healthy over SSH
- `terraform destroy` cleanly removes the VM
- `terraform apply` (again) rebuilds it identically from the same code

This proves the core infrastructure-as-code loop: declare, create, verify, destroy, recreate,
with zero manual VM configuration in Parallels' GUI.

## Roadmap

- [x] Provider authentication working against local `prldevops` API
- [x] Reusable `ubuntu-vm` module
- [x] First server (`web-server`) built, destroyed, and rebuilt via Terraform
- [x] DNS server (BIND9, authoritative zone `lab.local`, resolving via Terraform-built VM)
- [ ] DHCP server
- [ ] Additional server types
- [ ] Multi-environment support (dev / staging / production) via workspaces or `.tfvars`
- [ ] Automated infrastructure testing (`terraform validate`, `tflint`, Terratest/InSpec)
- [ ] CI pipeline (GitHub Actions) running plan/validate on every push

## Security notes

- Credentials (host password, API username/password, Parallels license) are supplied
  via `terraform.tfvars`, which is excluded from version control via `.gitignore`.
- `terraform.tfvars.example` documents the required variables with placeholder values only.
- No secrets are stored in any committed `.tf` file.
