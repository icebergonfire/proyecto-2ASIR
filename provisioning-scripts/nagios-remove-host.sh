#!/bin/bash
hostIP=$1
sudo rm /etc/nagios3/conf.d/$hostIP.cfg
sudo systemctl reload nagios3.service && echo "Done."
