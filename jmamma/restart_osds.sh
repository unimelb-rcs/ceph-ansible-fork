#!/bin/bash
for i in $(ls /var/lib/ceph/osd/); do echo $i; systemctl restart ceph-osd@$(echo $i | cut -f2 -d'-'); sleep 1; done
