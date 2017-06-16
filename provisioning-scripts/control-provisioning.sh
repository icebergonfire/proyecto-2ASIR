#!/bin/bash
cd /vagrant
sudo cp add-node.sh haproxy-add-host.sh haproxy-remove-host.sh nagios-remove-host.sh remove-node.sh /bin/
cd /bin
sudo chmod +x add-node.sh haproxy-add-host.sh haproxy-remove-host.sh nagios-remove-host.sh remove-node.sh