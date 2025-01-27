resource "libvirt_pool" "pool" {
    name = "${var.prefix}pool"
    type = "dir"
    path = "${var.pool_path}${var.prefix}pool"
}
resource "libvirt_volume" "image" {
    name = var.image.name
    format = "qcow2"
    pool = libvirt_pool.pool.name
    source = var.image.url
}
resource "libvirt_volume" "root" {
    count = length(var.vm)
    name = "${var.prefix}${var.vm[count.index].host}-root"
    pool = libvirt_pool.pool.name
    base_volume_id = libvirt_volume.image.id
    size = var.vm[count.index].disk

}
resource "libvirt_cloudinit_disk" "commoninit" {
     count = length(var.vm)
    name = "commoninit-${var.vm[count.index].host}.iso"
    user_data = templatefile("${path.module}/cloud/cloud_init.yaml",{
        hostname = var.vm[count.index].host
        fqdn = var.vm[count.index].fqdn
        users = var.static_data.users
        secret = var.static_data.secret
        keyroot = var.static_data.keyroot
        keyuser = var.static_data.keyuser
    })
    network_config = templatefile("${path.module}/cloud/network_config.yaml",{
        address = var.vm[count.index].ip
    })
    pool = libvirt_pool.pool.name
     
}
resource "libvirt_domain" "vm" {
    count = length(var.vm)
    name = "${var.prefix}${var.vm[count.index].host}"
    memory = var.vm[count.index].ram
    vcpu = var.vm[count.index].cpu
    cloudinit = element(libvirt_cloudinit_disk.commoninit.*.id, count.index)
    network_interface {
        macvtap = var.vm[count.index].macvtap 
    }
    disk {
        volume_id = libvirt_volume.root[count.index].id
    }
    console {
        type = "pty"
        target_port = "0"
        target_type = "serial"
    }
    console {
        type = "pty"
        target_port = "1"
        target_type = "virtio"
    
    }
    graphics {
        type = "vnc"
        listen_type = "address"
        autoport = true
    }
}

