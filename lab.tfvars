
environment = "lab"

vsphere_server = "10.126.201.15"

vsphere_user = "svc_ocp@ynap.labs"
vsphere_password = "OpenShift:20"

ocp_public_ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCupEezfH3SZOPwkhvteOIzxp5gQUOhAp0R4xoFh0H7PWTaroT2orL0DcGza4kRZ5M/jDzNsZBmOr3gZy1zraZNJ6FbANsKowdcs/fKETpTj4uY2ACCij/VKIzl9Io5gqDYMJxjD9AR/RGHrBznAoiciH97VjST6tLpemUcU3KppnIj253ddQ2ktg0K2EYrDK/ndlz0GmY4bdzFKkhwmBN9YQWoO4+/yHP1nO5VTZMDdSruIdFmUPMCOYhkjzujho1mjZilZb19vpcjPs0vh1s1pAQZFJN5T88J1ntNGqUI9m/GCADzz9WA8+a1hvOfwTyVywycL53MxE84bMBS4zhj ocp"

master_ips = [ "10.126.211.101", "10.126.211.102", "10.126.211.103" ]
worker_ips = [ "10.126.212.111", "10.126.212.112", "10.126.212.113" ]

bastion_ip = "10.126.213.15"

haproxy_ip = "10.126.213.18"

bootstrap_ip = "10.126.211.106"

primary_dns = "10.126.213.19"
secondary_dns = "8.8.8.8"

net_controlplane_gateway  = "10.126.211.1"
net_compute_gateway  = "10.126.212.1"
net_management_gateway  = "10.126.213.1"

netmask  = "24"

cluster_domain = "ocp.ynap.labs"