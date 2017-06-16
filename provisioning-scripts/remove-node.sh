#!/bin/bash

hostIP=$1

bash /bin/nagios-remove-host.sh $hostIP
bash /bin/haproxy-remove-host.sh $hostIP

sudo systemctl status nagios3.service
sudo systemctl status haproxy.service

cat /tmp/active-nodes.list | grep -v "$1" > /tmp/active-nodes.list.new
mv /tmp/active-nodes.list /tmp/active-nodes.list.new
