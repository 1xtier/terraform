variable "prefix" {
    type = string 
    default = "swarm"
}

variable "pool_path" {
    type = string 
    default = " /opt/kvms/vm2/"
}
 variable "image" {
    type = object({
        name = string
        url = string
    })
 }
 variable "static_data" {
    type = object({ 
    users = string
    secret = string
    keyroot = string 
    keyuser = string
    })
}
 variable "vm" {
    description = "List parametrs VM"
    type = list(object({
        cpu = number,
        ram = number,
        disk = number,
        macvtap = string,
        ip = string,
        host = string,
        fqdn = string
        
    }))
 }


