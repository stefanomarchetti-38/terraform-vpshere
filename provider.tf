provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

provider "archive" {}


data "vsphere_datacenter" "dc" {
}

data "vsphere_datastore" "datastore" {
    name = "BLQ-CC1-Lab-VVols"
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
    name          = "Synergy"
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "infrastructure_network" {
    name = "TN-lab-rtr-migr|AP-lab-rtr-migr|EPG-lab-srv3"
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "coreos_template" {
  name          = "CoreOS-template"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "net_controlplane" {
  name          = "TN-lab-rtr-migr|AP-lab-rtr-migr|EPG-lab-srv1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "net_compute" {
  name          = "TN-lab-rtr-migr|AP-lab-rtr-migr|EPG-lab-srv2"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "net_management" {
  name          = "TN-lab-rtr-migr|AP-lab-rtr-migr|EPG-lab-srv3"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "centos7_template" {
  name          = "centos7_template"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
