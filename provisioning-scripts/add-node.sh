#!/bin/bash

hostIP=$1
hostname=$2

bash /bin/nagios-add-host.sh $hostIP $hostname
bash /bin/haproxy-add-host.sh $hostIP $hostname

sudo systemctl status nagios3.service
sudo systemctl status haproxy.service
