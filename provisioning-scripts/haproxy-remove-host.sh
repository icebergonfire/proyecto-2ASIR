#!/bin/bash
hostIP=$1
sudo sed -i "/$1/d" /etc/haproxy/haproxy.cfg
sudo systemctl reload haproxy.service
