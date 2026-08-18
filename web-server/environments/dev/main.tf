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

module "web_server" {
  source = "../../../modules/ubuntu-vm"

  vm_name             = "web-server-dev"
  parallels_host      = "${var.parallels_host}:${var.parallels_port}"
  parallels_username  = var.parallels_username
  parallels_password  = var.parallels_password
  cpu_count           = var.vm_cpu_count
  memory_size         = var.vm_memory_size
  disk_size           = var.vm_disk_size
}
