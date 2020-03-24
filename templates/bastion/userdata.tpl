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
  - unzip
  - docker

write_files:
  - encoding: b64
    content: ${COMPOSE_ZIP}
    owner: root:root
    path: /tmp/compose.zip
    permissions: '0644'

runcmd:
  - systemctl enable docker
  - systemctl start docker
  - docker pull nginx
  - curl -sL "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  - chmod +x /usr/local/bin/docker-compose
  - ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
  - ls -l /tmp/compose.zip
  - mkdir -p /data/compose && unzip -o -d /data/compose /tmp/compose.zip && rm /tmp/compose.zip
  - mkdir -p /data/www/web && chmod 777 /data/www/web
  - cd /data/compose && docker-compose up --build -d
  - curl -s https://mirror.openshift.com/pub/openshift-v4/clients/ocp/4.3.0/openshift-install-linux-4.3.0.tar.gz | tar -C /usr/local/sbin -xzf - openshift-install
  - curl -s https://mirror.openshift.com/pub/openshift-v4/clients/oc/4.3.0-202001240552.git.0.8f06d10.el7/linux/oc.tar.gz | tar -C /usr/local/sbin -xzf -
