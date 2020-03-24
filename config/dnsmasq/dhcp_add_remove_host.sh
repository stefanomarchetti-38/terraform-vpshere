#!/bin/bash

# The arguments sent to the script are "add" or "del",
# then the MAC address, the IP address and finally the hostname

OPERATION="${1:-}"
MAC="${2:-}"
IP="${3:-}"
HOSTNAME="${4:-}"

tstamp="`date '+%Y-%m-%d %H:%M:%S'`"

echo "${tstamp}"
echo "OPERATION: ${OPERATION}" > /root/dhcp_result.txt
echo "MAC: ${MAC}" >> /root/dhcp_result.txt
echo "IP: ${IP}" >> /root/dhcp_result.txt
echo "HOSTNAME: ${HOSTNAME}" >> /root/dhcp_result.txt

if [ ${OPERATION} == 'add' ]; then
  echo -e "${IP}\t${HOSTNAME}" >> /etc/hosts
  systemctl restart dnsmasq
elif [ ${OPERATION} == 'del' ]; then
  sed -i "/^${IP}/d" /etc/hosts
  systemctl restart dnsmasq
fi