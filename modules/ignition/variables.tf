variable "ip_addresses" {
  type = list
}

variable "cluster_domain" {
  type = string
}

variable "instance_count" {
  type = string
}

variable "ignition" {
  type = string
}

variable "role" {
  type = string
}

variable "netmask" {
    type = string
}

variable "network_gateway" {
    type = string
}

variable "primary_dns" {
  type = string
}

variable "secondary_dns" {
  type = string
}

