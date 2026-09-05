output "control_plane_ips" {
  description = "Control plane IP addresses"

  value = [
    for vm in proxmox_vm_qemu.control_plane : vm.default_ipv4_address
  ]
}

output "worker_ips" {
  description = "Worker node IP addresses"

  value = [
    for vm in proxmox_vm_qemu.worker : vm.default_ipv4_address
  ]
}

output "control_plane_names" {
  value = [
    for vm in proxmox_vm_qemu.control_plane : vm.name
  ]
}

output "worker_names" {
  value = [
    for vm in proxmox_vm_qemu.worker : vm.name
  ]
}