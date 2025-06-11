# 🧪 Maldonado Homelab

Welcome to the Maldonado Homelab — a modular, infrastructure-as-code-driven environment for testing, development, and automation. This lab is built to support hands-on experimentation with modern DevOps, networking, and security tools. The focus is on automation, observability, and clean infrastructure practices. 


Note - This repo/readme will get updates sparingly as I am now using a selfhosted GitLab instance to host all my homelab code.


---

## 🏗️ Core Architecture

- **Virtualization Platform**: [Proxmox VE](https://www.proxmox.com/en/) (3-node cluster - 192GB RAM, 112 cores)
  - Dell r630 - 32x cores, 64gb RAM
  - Dell r630 - 48x cores, 64gb RAM
  - Dell t630 - 32x cores, 64gb RAM
  - Each host has at least one 10Gb SFP+ NIC
  - Supports LXC containers and KVM virtual machines
- **Primary DNS Infrastructure**: `BIND9` (Authoritative)
  - Secondary: `Pi-hole` for recursive resolution and ad-blocking
  - Dynamic DNS entries managed via Terraform and GitLab CI/CD
- **Monitoring**: InfluxDB, Loki, Prometheus for tracking metrics and logs across the whole lab
- **Visualization**: Grafana
- **Primary Remote Management**: `Wireguard`
  - Secondary: `OpenVPN`

---

## 🔐 Networking & Firewall

- **Firewall**:
  - ER8411

- **Switches**:
  - SG2008P
  - SG3428X-M2
  - SX3008F
 
- **NOTE**: Recently migrated network infrastructure to TP-Link Omada devices, the devices below were my "prod" network for the past 5 years. The reason for migration was mainly sound and heat, the Cisco devices were not great for running behind my desk. 
  - Cisco Nexus 5548UP
  - Nexus 3048TP
  - Cisco Catalyst 2960S
  - pfSense (Dell r610)


- **IPAM & Source of Truth**: [NetBox](https://netbox.dev/)
  - Used for tracking IPs, DNS names, cluster inventory
  - Synchronized with Terraform deployments and Omada clients

---

## 🛠️ Automation Stack

| Tool       | Purpose                                                                 |
|------------|-------------------------------------------------------------------------|
| **Terraform** | Infrastructure provisioning (VMs, Docker hosts, DNS records, etc.)   |
| **Ansible**   | Configuration management (networking, GitLab Runners, etc.)          |
| **GitLab CI** | Pipeline automation (Terraform apply, DNS sync, deployment workflows) |
| **Python**    | Scripts for NetBox sync, Omada client parsing, etc.                  |

---

## ⚙️ Projects & Features

### 🧠 Source of Truth (NetBox)
- Dynamic updates via:
  - Terraform → NetBox sync for IPs and DNS
  - Omada → NetBox sync for wireless clients with tagging
- Tags (e.g., `dns-automation`, `omada-dynamic`) for classifying entries

### 🛰️ Launchpad Server
- Acts as:
  - SSH bastion host
  - Development and testing sandbox
- Provisioned using Terraform + Ansible with NetBox DNS/IP resolution

### 🧩 DNS Automation
- Terraform-managed zone entries for `BIND9`
- NetBox acts as the single source of truth for DNS records
- Dynamic updates with rollback-safe Git commits and CI/CD integration

### 📦 Docker Automation
- Declarative `docker-compose.yml` deployment via GitLab Terraform provider
- Declarative port mappings maintained in Git
- Support for both production and test Docker hosts

### 🧰 GitLab Runner Provisioning
- Runners automatically deployed on Proxmox via:
  - Terraform (VM creation)
  - Ansible (GitLab Runner install + registration)
  - NetBox IP conflict avoidance

---

## 📚 Learning & Certifications

- Mini threat hunts and custom detection logic under development for SOC simulation with Security Onion.

---

## 📅 Scheduling & Workflow

- Infrastructure designed for minimal manual intervention and fast redeploys

---

## 💡 Roadmap

- 🔍 Implement mini SOC with custom detection rules and log analysis
- 🔄 Full GitOps pipeline from commit → deploy → NetBox/DNS sync
- 🔌 Implement Terraform module for NetBox-native VM provisioning

---

