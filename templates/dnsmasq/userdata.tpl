#cloud-config

users:
  - name: ocp
    ssh-authorized-keys:
     - ${OCP_PUBLIC_SSH_KEY}
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    groups: sudo
    shell: /bin/bash

packages:
  - curl
  - dnsmasq

write_files:
  - encoding: b64
    content: ${DNSMASQ_CONF}
    owner: root:root
    path: /etc/dnsmasq.conf
    permissions: '0644'

runcmd:
  - systemctl enable dnsmasq
  - systemctl restart dnsmasq
  - sed -i "/^nameserver ${SECONDARY_DNS}/d" /etc/resolv.conf