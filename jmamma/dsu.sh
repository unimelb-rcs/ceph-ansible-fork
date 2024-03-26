#!/bin/bash

function wait_check () {
  while [ "$(ceph --name client.bootstrap-osd --keyring /var/lib/ceph/bootstrap-osd/ceph.keyring --cluster ceph status | grep -c -e ERROR -e down -e reduced -e peering -e activating)" -gt 0 ]; do
    sleep 1
  done
}

wait_check

systemctl stop ceph-osd@*.service


wait_check 



