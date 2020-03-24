#cloud-config

users:
  - name: ocp
    ssh-authorized-keys:
     - ${OCP_PUBLIC_SSH_KEY}
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    groups: sudo
    shell: /bin/bash

packages:
  - ntp
  - dhcp
  - curl

write_files:
  - encoding: b64
    content: ${DHCPD_CONF}
    owner: root:root
    path: /etc/dhcp/dhcpd.conf
    permissions: '0644'

runcmd:
  - systemctl enable ntpd
  - systemctl start ntpd
  - systemctl enable dhcpd
  - systemctl restart dhcpd
