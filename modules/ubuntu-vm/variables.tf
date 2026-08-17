variable "vm_name" {
  description = "Name of the virtual machine, must be unique on the host"
  type        = string
}

variable "vm_owner" {
  description = "Owner tag for the VM"
  type        = string
  default     = "lab_admin"
}

variable "box_name" {
  description = "Vagrant box to build the VM from"
  type        = string
  default     = "bento/ubuntu-22.04"
}

variable "box_version" {
  description = "Pin a specific box version. Leave empty for latest."
  type        = string
  default     = ""
}

variable "cpu_count" {
  description = "Number of vCPUs"
  type        = string
  default     = "2"
}

variable "memory_size" {
  description = "Memory in megabytes"
  type        = string
  default     = "2048"
}

variable "disk_size" {
  description = "Disk size in megabytes"
  type        = string
  default     = "20480"
}

variable "start_headless" {
  description = "Run the VM without a GUI window"
  type        = bool
  default     = true
}

variable "auto_start_on_host" {
  description = "Start this VM automatically when the Mac boots"
  type        = bool
  default     = false
}

variable "parallels_host" {
  description = "Host:port of the Parallels DevOps API"
  type        = string
}

variable "parallels_username" {
  description = "Username to authenticate with the Parallels DevOps API"
  type        = string
}

variable "parallels_password" {
  description = "Password to authenticate with the Parallels DevOps API"
  type        = string
  sensitive   = true
}
