variable "proxmox_node" {
  description = "Proxmox node name"
  type        = string
  default     = "dev-monitor"
}

variable "template_vmid" {
  description = "Proxmox VM template ID"
  type        = number
  default     = 121
}
variable "template_name" {
  description = "Name of the Proxmox VM template"
  type        = string
  default     = "Ubuntu-k-test"
}

variable "control_plane_count" {
  description = "Number of Kubernetes control-plane VMs"
  type        = number
  default     = 1
}

variable "worker_count" {
  description = "Number of Kubernetes worker VMs"
  type        = number
  default     = 2
}
variable "control_plane_ips" {
  type = list(string)
}

variable "worker_ips" {
  type = list(string)
}

variable "network_prefix" {
  type    = number
  default = 24
}

variable "network_gateway" {
  type = string
}