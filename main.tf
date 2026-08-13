terraform {
  required_providers {
    parallels-desktop = {
      source = "Parallels/parallels-desktop"
    }
  }
}

provider "parallels-desktop" {
  host                    = "${var.parallels_host}:${var.parallels_port}"
  username                = var.parallels_username
  password                = var.parallels_password
  license                 = var.parallels_license
  disable_tls_validation  = true
}
