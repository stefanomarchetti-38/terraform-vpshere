variable "vsphere_user" {
    description = "Username for logging into the designated vCenter"
}

variable "vsphere_password" {
    description = "Password for logging into the designated vCenter"
}

variable "vsphere_server" {
  description = "vSphere vCenter endpoint"
}

variable "environment" {
  description = "One of: lab, dev, prf, int, prd"
}

variable "masters_count" {
  description = "Number of master instances"
  default = 3
}

variable "workers_count" {
  description = "Number of worker instances"
  default = 3
}

variable "cluster_domain" {
  description = "Cluster domain"
  default = ""
}

variable "haproxy_count" {
  description = "Number of HAProxy instance"
  default = 1
}

variable "haproxy_machine_name" {
  description = "Name for HAProxy instance"
  default = "haproxy"
}

variable "haproxy_ip" {
  description = "HAProxy IP address"
  default = ""
}

variable "ocp_public_ssh_key" {
  description = "ocp user public ssh key"
  default = ""
}

variable "master_ips" {
  description = "Master IPs address"
  type    = list
  default = []
}

variable "worker_ips" {
  description = "Worker IPs address"
  type    = list
  default = []
}

variable "bootstrap_ip" {
  description = "Bootstrap IP address"
  default = ""
}

variable "bastion_ip" {
  description = "Bastion IP address"
  default = ""
}

variable "primary_dns" {
  default = ""
} 

variable "secondary_dns" {
  default = ""
}

variable "netmask" {
  default = ""
}

variable "dhcp_machine_name" {
  description = "Name for DHCP instance"
  default = "dhcp"
}

variable "dns_machine_name" {
  description = "Name for DNS instance"
  default = "dnsmasq"
}

variable "bastion_machine_name" {
  description = "Name for BASTION instance"
  default = "bastion"
}

variable "net_controlplane_gateway" {
  description = "Gateway Control Plane Subnet"
}

variable "net_compute_gateway" {
  description = "Gateway Compute Subnet"
}

variable "net_management_gateway" {
  description = "Gateway Management Subnet"
}

