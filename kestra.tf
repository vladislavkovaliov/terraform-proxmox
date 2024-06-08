resource "proxmox_lxc" "kestra" {
  hostname = "lxc-basic-temp"

  target_node = "pve"

  unprivileged = true

  ostemplate = "wd:vztmpl/alpine-3.19-default_20240207_amd64.tar.xz"

  password = "alpine"

  start = true

  swap = 512

  cores = 1

  memory = 512

  # ssh_public_keys = file("~/.ssh/id_rsa.pub")

  features {
    nesting = true
  }

  rootfs {

    storage = "local-lvm"

    size = "1G"

  }

  network {

    name = "eth0"

    bridge = "vmbr0"

    # TODO: input right IP address
    # INFO: No worry it is local network
    ip = "192.168.100.90/24"

  }

}

output "container_ip" {
  value = proxmox_lxc.template-demo-1.id
}
