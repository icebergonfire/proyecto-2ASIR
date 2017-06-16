#!/bin/bash
DEBIAN_FRONTEND=noninteractive sudo apt-get -y install nmap
touch /tmp/list-of-nodes.list /tmp/active-nodes.list
sudo cp /vagrant/scan-local-network-for-nodes.sh /bin/
sudo chmod +x /bin/scan-local-network-for-nodes.sh
sudo -u root bash -c 'cat <<EOF > /etc/cron.d/addnodes
*/5 * * * * root bash -c "/bin/scan-local-network-for-nodes.sh" >> /tmp/last-scan.log 2>&1
EOF'
sudo chmod +x /etc/cron.d/addnodes

