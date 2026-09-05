resource "local_file" "ansible_inventory" {
  filename = "${path.module}/ansible/inventory.ini"

  content = <<-EOT
[control_plane]
%{for index, vm in proxmox_vm_qemu.control_plane~}
k8s-cp-${index + 1} ansible_host=${vm.default_ipv4_address}
%{endfor~}

[workers]
%{for index, vm in proxmox_vm_qemu.worker~}
k8s-worker-${index + 1} ansible_host=${vm.default_ipv4_address}
%{endfor~}

[kubernetes:children]
control_plane
workers

[kubernetes:vars]
ansible_user=admin1
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_private_key_file=~/.ssh/id_rsa
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
EOT
}