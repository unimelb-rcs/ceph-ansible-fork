#!/bin/bash

function wait_check () {
  while [ "$(ceph --name client.bootstrap-osd --keyring /var/lib/ceph/bootstrap-osd/ceph.keyring --cluster ceph status | grep -c -e degraded -e ERROR -e reduced -e peering -e activating)" -gt 0 ]; do
    sleep 1
  done
}

wait_check

for unit in $(systemctl list-units | grep -E "loaded * active" | grep -oE "ceph-osd@([0-9]+).service"); do
  # First, restart daemon(s)
  wait_check
  systemctl restart "${unit}"
  sleep 2
done

wait_check 
