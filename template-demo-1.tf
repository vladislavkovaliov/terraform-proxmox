resource "proxmox_lxc" "template-demo-1" {
  hostname = "lxc-basic-temp"

  target_node = "pve"

  unprivileged = true

  ostemplate = "wd:vztmpl/alpine-3.18-default_20230607_amd64.tar.xz"

  start = true

  swap = 512

  cores = 1

  memory = 512

  rootfs {

    storage = "local-lvm"

    size = "768MB"

  }

  network {

    name = "eth0"

    bridge = "vmbr0"

    ip = "dhcp"

  }
}
