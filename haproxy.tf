
resource "vsphere_virtual_machine" "ocp_haproxy" {

  name                          = var.haproxy_machine_name
  resource_pool_id              = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id                  = data.vsphere_datastore.datastore.id
  # datastore_cluster_id = data.vsphere_datastore_cluster.datastore_cluster.id
  
  num_cpus    = 2
  memory      = 4096
  
  guest_id = data.vsphere_virtual_machine.centos7_template.guest_id
  folder        = "ocp"
  enable_disk_uuid              = "true"
  wait_for_guest_net_timeout    = "0"
  wait_for_guest_net_routable   = "true"
  
  cpu_hot_add_enabled           = "true"
  cpu_hot_remove_enabled        = "true"
  memory_hot_add_enabled        = "true"

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
    "guestinfo.userdata"          = base64gzip(templatefile("${path.module}/templates/${var.haproxy_machine_name}/haproxy_userdata.tpl", { 
      OCP_PUBLIC_SSH_KEY  = var.ocp_public_ssh_key,
      HAPROXY_CONF        = base64encode(templatefile("${path.module}/../config/${var.haproxy_machine_name}/haproxy.cfg", { 
        MASTER_IPS = var.master_ips, 
        COMPUTE_IDS = var.worker_ips,
        BOOTSTRAP_IP = var.bootstrap_ip,
        CLUSTER_DOMAIN  = var.cluster_domain
        }))
      }))
    "guestinfo.userdata.encoding" = "gzip+base64"
    "guestinfo.metadata"          = base64gzip(templatefile("${path.module}/templates/metadata.tpl", {
      INSTANCE_ID = var.haproxy_machine_name,
      NETWORK_CONFIG = base64gzip(templatefile("${path.module}/templates/${var.haproxy_machine_name}/haproxy_metadata.yml", { 
        CLUSTER_DOMAIN  = var.cluster_domain, 
        HAPROXY_IP      = "${var.haproxy_ip}/${var.netmask}",
        NETWORK_GATEWAY = var.net_management_gateway,
        PRIMARY_DNS     = var.primary_dns,
        SECONDARY_DNS     = var.secondary_dns
        }))
      }))
    "guestinfo.metadata.encoding" = "gzip+base64"
  } 

}