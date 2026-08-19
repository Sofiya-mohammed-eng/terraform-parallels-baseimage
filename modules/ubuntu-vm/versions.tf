terraform {
  required_version = ">= 1.15.0"

  required_providers {
    parallels-desktop = {
      source  = "Parallels/parallels-desktop"
      version = "~> 0.7"
    }
  }
}
