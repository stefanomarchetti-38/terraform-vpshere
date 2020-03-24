resource "vsphere_virtual_machine" "dhcp" {
  name             = var.dhcp_machine_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  # datastore_cluster_id = data.vsphere_datastore_cluster.datastore_cluster.id
  datastore_id = data.vsphere_datastore.datastore.id
  folder = "ocp"


  num_cpus = 2
  memory   = 1024
  guest_id = data.vsphere_virtual_machine.centos7_template.guest_id

  scsi_type = data.vsphere_virtual_machine.centos7_template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.net_controlplane.id
    adapter_type = "vmxnet3"
  }

  network_interface {
    network_id   = data.vsphere_network.net_compute.id
    adapter_type = "vmxnet3"
  }

  network_interface {
    network_id   = data.vsphere_network.net_management.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.centos7_template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.centos7_template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.centos7_template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.centos7_template.id
  }

  extra_config = {
    "guestinfo.userdata"          = base64gzip(templatefile("${path.module}/templates/${var.dhcp_machine_name}/userdata.tpl", { OCP_PUBLIC_SSH_KEY = var.ocp_public_ssh_key, DHCPD_CONF = base64encode(file("${path.module}/../config/${var.dhcp_machine_name}/dhcpd.conf")) }))
    "guestinfo.userdata.encoding" = "gzip+base64"
    "guestinfo.metadata"          = base64gzip(templatefile("${path.module}/templates/metadata.tpl", { NETWORK_CONFIG = base64gzip(file("${path.module}/templates/${var.dhcp_machine_name}/metadata.yml")), INSTANCE_ID = var.dhcp_machine_name }))
    "guestinfo.metadata.encoding" = "gzip+base64"
  }
}
