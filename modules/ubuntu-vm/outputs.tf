output "vm_id" {
  description = "The ID of the created virtual machine"
  value       = parallels-desktop_vagrant_box.this.id
}

output "internal_ip" {
  description = "Internal IP address of the VM"
  value       = parallels-desktop_vagrant_box.this.internal_ip
}

output "external_ip" {
  description = "External IP address of the VM"
  value       = parallels-desktop_vagrant_box.this.external_ip
}

output "os_type" {
  description = "Detected OS type of the VM"
  value       = parallels-desktop_vagrant_box.this.os_type
}
