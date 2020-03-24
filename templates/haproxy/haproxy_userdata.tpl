#cloud-config

users:
  - name: ocp
    ssh-authorized-keys:
     - ${OCP_PUBLIC_SSH_KEY}
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    groups: sudo
    shell: /bin/bash

packages:
  - haproxy
  - policycoreutils-python

write_files:
  - path: /etc/haproxy/haproxy.cfg
    owner: root:root
    permissions: '0644'
    encoding: b64
    content: ${HAPROXY_CONF}
    
runcmd:
  - systemctl enable haproxy
  - systemctl restart haproxy