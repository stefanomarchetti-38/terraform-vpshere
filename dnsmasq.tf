resource "vsphere_virtual_machine" "dnsmasq" {
  
  name             = var.dns_machine_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  # datastore_cluster_id = data.vsphere_datastore_cluster.datastore_cluster.id
  datastore_id = data.vsphere_datastore.datastore.id
  folder = "ocp"


  num_cpus = 2
  memory   = 1024
  guest_id = data.vsphere_virtual_machine.centos7_template.guest_id

  scsi_type = data.vsphere_virtual_machine.centos7_template.scsi_type

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
    "guestinfo.userdata"          = base64gzip(templatefile("${path.module}/templates/${var.dns_machine_name}/userdata.tpl", { 
      OCP_PUBLIC_SSH_KEY  = var.ocp_public_ssh_key,
      CLUSTER_DOMAIN      = var.cluster_domain,
      SECONDARY_DNS       = var.secondary_dns
      DNSMASQ_CONF        = base64encode(templatefile("${path.module}/../config/${var.dns_machine_name}/dnsmasq.conf", {
        IP_INTERFACE  = var.primary_dns,
        BASTION_IP    = var.bastion_ip,
        BOOTSTRAP_IP  = var.bootstrap_ip,
        HAPROXY_IP    = var.haproxy_ip,
        MASTER_IPS    = var.master_ips,
        WORKER_IPS    = var.worker_ips,
        CLUSTER_DOMAIN  = var.cluster_domain
      }))
     }))
    "guestinfo.userdata.encoding" = "gzip+base64"
    "guestinfo.metadata"          = base64gzip(templatefile("${path.module}/templates/metadata.tpl", {
      INSTANCE_ID = var.dns_machine_name,
      NETWORK_CONFIG = base64gzip(templatefile("${path.module}/templates/${var.dns_machine_name}/metadata.yml", { 
        CLUSTER_DOMAIN  = var.cluster_domain, 
        DNSMASQ_IP      = "${var.primary_dns}/${var.netmask}",
        NETWORK_GATEWAY = var.net_management_gateway,
        SECONDARY_DNS   = var.secondary_dns
        }))
      }))
    "guestinfo.metadata.encoding" = "gzip+base64"
  }
}