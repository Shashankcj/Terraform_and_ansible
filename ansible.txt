resource "null_resource" "run_ansible" {
  depends_on = [
    proxmox_vm_qemu.control_plane,
    proxmox_vm_qemu.worker,
    local_file.ansible_inventory   
  ]

  provisioner "local-exec" {
    command = <<-EOT
      set -e

      echo "Waiting for all hosts to respond to ping..."
      for i in $(seq 1 30); do
        if ansible all -i ${path.module}/ansible/inventory.ini -m ping > /tmp/ansible_ping.log 2>&1; then
          echo "All hosts reachable."
          break
        fi
        echo "Not ready yet, retrying in 10s... (attempt $i/30)"
        sleep 10
      done

      cat /tmp/ansible_ping.log

      echo "Running deploy-cluster.yml..."
      ansible-playbook -i ${path.module}/ansible/inventory.ini ${path.module}/ansible/playbook/deploy-cluster.yml
    EOT
  }
}