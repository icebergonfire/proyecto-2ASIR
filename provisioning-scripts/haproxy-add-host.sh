#!/bin/bash
hostIP=$1
hostName=$2
configurationLine="     server $2 $1:8080 maxconn 300 check"
sudo sed -i "/#node_list_end/i\ $configurationLine" /etc/haproxy/haproxy.cfg
sudo systemctl reload haproxy.service
