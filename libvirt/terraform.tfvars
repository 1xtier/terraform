prefix = ""
pool_path = ""
static_data = {
users = ""
secret = ""
keyroot = ""
keyuser = ""
}
image = {
    name = "swarm-manager"
    url = "https://cloud-images.ubuntu.com/noble/20250122/noble-server-cloudimg-amd64.img"
}
 vm = [
    {
    macvtap = "enp4s0"
    cpu = 1 
    disk = 35 * 1024 * 1024 * 1024
    ram = 2048
    ip = "192.168.19.91"
    host = "manager1"
    fqdn = "manager1.redfex.loc"
 },
 {
    macvtap = "enp4s0"
    cpu = 1 
    disk = 35 * 1024 * 1024 * 1024
    ram = 2048
    ip = "192.168.19.92"
    host = "worker1"
    fqdn = "workwer1.redfex.loc"
 }
 ]
