terraform {
  required_providers {
    parallels-desktop = {
      source = "Parallels/parallels-desktop"
    }
  }
}

provider "parallels-desktop" {
  disable_tls_validation = true
}
