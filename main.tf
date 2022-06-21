terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
      version = "~>0.6"
    }
    template = {
      source = "hashicorp/template"
      version = "~>2.2"
    }
  }
}

provider "libvirt" {
  # Configuration options
  uri = var.qemu_uri
}

resource "libvirt_pool" "runners" {
  name = "runners"
  type = "dir"
  path = var.pool_dir
}

resource "libvirt_network" "runner_network" {
  name      = "runner_network"
  mode      = "nat"
  addresses = ["10.17.3.0/24"]
  dhcp {
    enabled = true
  }
  dns {
    enabled = true
  }
}

data "template_file" "user_data" {
  count    = var.servers
  template = file("${path.module}/cloud_init.yaml")
  vars = {
    github_token   = var.github_token
    github_repo    = var.github_repo
    runner_version = var.runner_version
    count          = count.index
    arch = var.arch == "aarch64" ? "arm64" : "x86_64" # used for the runner arch packages
  }
}

resource "libvirt_cloudinit_disk" "commoninit" {
  count     = var.servers
  name      = "commoninit-${count.index}.iso"
  user_data = data.template_file.user_data[count.index].rendered
  pool      = libvirt_pool.runners.name
  lifecycle {
    ignore_changes = [user_data] # This avoids terraform thinking the whole thing needs to be destroyed when the vars change
  }
}

resource "libvirt_volume" "jeos" {
  name   = "opensuse-15.4-jeos-${var.arch}.qcow2"
  source = var.arch == "x86_64" ? "https://download.opensuse.org/distribution/leap/15.4/appliances/openSUSE-Leap-15.4-JeOS.x86_64-15.4-OpenStack-Cloud-Current.qcow2" : "https://download.opensuse.org/distribution/leap/15.4/appliances/openSUSE-Leap-15.4-ARM-JeOS-efi.aarch64.qcow2"
  format = "qcow2"
}

resource "libvirt_volume" "volume" {
  count          = var.servers
  name           = "volume-${count.index}.qcow2"
  base_volume_id = libvirt_volume.jeos.id
  size           = 128849018880
  pool           = libvirt_pool.runners.name
}

resource "libvirt_domain" "github_runner" {
  count     = var.servers
  name      = "github-runner-${count.index}"
  vcpu      = var.vcpu
  memory    = var.memory
  machine = var.arch == "aarch64" ? "virt" : "q35"
  arch = var.arch

  cpu {
    mode = "host-passthrough"
  }

  cloudinit = libvirt_cloudinit_disk.commoninit[count.index].id

  disk {
    volume_id = element(libvirt_volume.volume.*.id, count.index)
    scsi      = true
  }
  network_interface {
    network_id     = libvirt_network.runner_network.id
    network_name   = libvirt_network.runner_network.name
    wait_for_lease = true
  }
  xml {
    xslt = file("sataCD.xsl") # This replaces on the fly the IDE cdrom for a sata one so its compatible on arm64
  }
}

output "ips" {
  value = zipmap("${libvirt_domain.github_runner.*.name}", "${libvirt_domain.github_runner.*.network_interface.0.addresses.0}")
  description = "Pair of nodename:IP of created VMs"
}