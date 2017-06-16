#!/bin/bash
cd /tmp/
wget https://kent.dl.sourceforge.net/project/ddclient/ddclient/ddclient-3.8.3.tar.bz2
tar -xf ddclient-3.8.3.tar.bz2
sudo cp ddclient-3.8.3/ddclient /bin
sudo chmod +x /bin/ddclient

sudo bash -c 'cat <<EOF > /etc/ddclient.conf
use=web, web=dynamicdns.park-your-domain.com/getip
protocol=namecheap 
server=dynamicdns.park-your-domain.com 
login=josuealvarezmoreno.es
password=5093a659171a482c9c9631aeeda586d4
proyecto
EOF
'

sudo cp /vagrant/update-dns.sh /bin/
sudo chmod +x /bin/update-dns.sh
