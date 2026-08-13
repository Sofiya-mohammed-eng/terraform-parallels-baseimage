variable "parallels_host" {
  description = "Host/IP where the Parallels DevOps agent is running"
  type        = string
  default     = "localhost"
}

variable "parallels_port" {
  description = "Port for the Parallels DevOps API bridge"
  type        = string
  default     = "8088"
}

variable "parallels_username" {
  description = "Username for the Parallels DevOps API"
  type        = string
}

variable "parallels_password" {
  description = "Password/token for the Parallels DevOps API"
  type        = string
  sensitive   = true
}

variable "parallels_license" {
  description = "Parallels Desktop Pro/Business license key"
  type        = string
  sensitive   = true
}
