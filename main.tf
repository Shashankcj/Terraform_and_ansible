resource "proxmox_vm_qemu" "control_plane" {
  count = var.cluster_count * var.control_plane_count

  name        = "k8s-cluster-${floor(count.index / var.control_plane_count) + 1}-cp-${(count.index % var.control_plane_count) + 1}"
  target_node = var.proxmox_node

  clone      = var.template_name
  full_clone = true

  cpu {
    cores   = 4
    sockets = 1
  }

  memory = 8192

  agent = 1

  os_type = "cloud-init"

  scsihw = "virtio-scsi-single"
  disk {
    slot     = "scsi0"
    type     = "disk"
    storage  = "DATA-OS"
    size     = "32G"
    iothread = true
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr1"
  }
  # Static IP configuration
  #ipconfig0 = "ip=${var.control_plane_ips[count.index]}/${var.network_prefix},gw=${var.network_gateway}"
}

resource "proxmox_vm_qemu" "worker" {
  count = var.cluster_count * var.worker_count

  name        = "k8s-cluster-${floor(count.index / var.worker_count) + 1}-worker-${(count.index % var.worker_count) + 1}"
  target_node = var.proxmox_node

  clone      = var.template_name
  full_clone = true

  cpu {
    cores   = 4
    sockets = 1
  }

  memory = 8192

  agent = 1

  os_type = "cloud-init"

  scsihw = "virtio-scsi-single"

  disk {
    slot     = "scsi0"
    type     = "disk"
    storage  = "DATA-OS"
    size     = "32G"
    iothread = true
  }


  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr1"
  }
  # Static IP configuration
  #ipconfig0 = "ip=${var.worker_ips[count.index]}/${var.network_prefix},gw=${var.network_gateway}"
}