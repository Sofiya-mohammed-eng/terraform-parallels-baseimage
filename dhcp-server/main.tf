terraform {
  required_providers {
    parallels-desktop = {
      source = "Parallels/parallels-desktop"
    }
  }
}

provider "parallels-desktop" {
  license                 = var.parallels_license
  disable_tls_validation  = true
}

module "dhcp_server" {
  source = "../modules/ubuntu-vm"

  vm_name             = "dhcp-server-01"
  parallels_host      = "${var.parallels_host}:${var.parallels_port}"
  parallels_username  = var.parallels_username
  parallels_password  = var.parallels_password
}
