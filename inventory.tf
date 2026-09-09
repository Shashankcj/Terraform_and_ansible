resource "local_file" "ansible_inventory" {
  filename = "${path.module}/ansible/inventory.ini"

  content = <<-EOT

# ==========================

# All Control Planes

# ==========================

[control_plane:children]
cluster1_control_plane
cluster2_control_plane

# ==========================

# All Workers

# ==========================

[workers:children]
cluster1_workers
cluster2_workers

# ==========================

# Kubernetes Cluster 1

# ==========================

[cluster1_control_plane]
k8s-cluster-1-cp-1 ansible_host=${proxmox_vm_qemu.control_plane[0].default_ipv4_address}

[cluster1_workers]
%{for index in range(var.worker_count)~}
k8s-cluster-1-worker-${index + 1} ansible_host=${proxmox_vm_qemu.worker[index].default_ipv4_address}
%{endfor~}

[cluster1:children]
cluster1_control_plane
cluster1_workers

[cluster1:vars]
kube_vip=10.99.1.249
control_plane_host=k8s-cluster-1-cp-1

# ==========================

# Kubernetes Cluster 2

# ==========================

[cluster2_control_plane]
k8s-cluster-2-cp-1 ansible_host=${proxmox_vm_qemu.control_plane[1].default_ipv4_address}

[cluster2_workers]
%{for index in range(var.worker_count)~}
k8s-cluster-2-worker-${index + 1} ansible_host=${proxmox_vm_qemu.worker[var.worker_count + index].default_ipv4_address}
%{endfor~}

[cluster2:children]
cluster2_control_plane
cluster2_workers

[cluster2:vars]
kube_vip=10.99.1.250
control_plane_host=k8s-cluster-2-cp-1

# ==========================

# Ansible Configuration

# ==========================

[all:vars]
ansible_user=admin1
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_private_key_file=~/.ssh/id_rsa
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

EOT
}
