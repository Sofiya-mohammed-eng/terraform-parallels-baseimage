resource "parallels-desktop_vagrant_box" "this" {
  name        = var.vm_name
  owner       = var.vm_owner
  box_name    = var.box_name
  box_version = var.box_version != "" ? var.box_version : null
  host        = var.parallels_host

  authenticator {
    username = var.parallels_username
    password = var.parallels_password
  }

  specs {
    cpu_count   = var.cpu_count
    memory_size = var.memory_size
    disk_size   = var.disk_size
  }

  config {
    start_headless     = var.start_headless
    auto_start_on_host = var.auto_start_on_host
  }
}
