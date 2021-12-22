  terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = "2.0.2"
    }
  }
}

provider "vsphere" {
  user           = "administrator@maldonado.tech"
  password       = "PASSWORD"
  vsphere_server = "vcenter.maldonado.tech"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

module "Create-Ubuntu-Server" {
  source    = "Terraform-VMWare-Modules/vm/vsphere"
  version   = "3.4.0"
  vmtemp    = "Ubuntu-Server-Template"
  instances = 1
  vmname    = "terraform-template-testing"
  vmrp      = "/homelab/host/esxi01.maldonado.tech/Resources"
  network = {
    "VM Network" = ["",""]
  }
  vmgateway = "192.168.1.1"
  dc        = "homelab"
  datastore = "VM Storage"
}

