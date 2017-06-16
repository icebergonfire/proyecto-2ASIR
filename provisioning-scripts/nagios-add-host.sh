#!/bin/bash
hostIP=$1
hostname=$2
ownIP=`ip -o -4 addr | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v -E "*255$" | grep -v 10.0.2.15 | grep -v 255.255.255.0 | grep -v 127.0.0.1 | grep -v 255.0.0.0`
sudo cp  /etc/nagios3/conf.d/nodes.template /etc/nagios3/conf.d/$hostname.cfg
sudo sed -i "s/#NODE-HOSTNAME#/$hostname/" /etc/nagios3/conf.d/$hostname.cfg
sudo sed -i "s/#NODE-IP#/$hostIP/" /etc/nagios3/conf.d/$hostname.cfg
echo "#!/bin/bash" > /tmp/addHost.sh
echo "sed -i \"s/.*allowed_hosts.*/allowed_hosts=127.0.0.1,$ownIP/\" /etc/nagios/nrpe.cfg" >> /tmp/addHost.sh
echo "service nagios-nrpe-server restart" >> /tmp/addHost.sh
chmod +x /tmp/addHost.sh
scp -o BatchMode=yes -o ConnectTimeout=10 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /home/puppet/.ssh/id_rsa /tmp/addHost.sh puppet@$hostIP:/tmp/

ssh -n -o BatchMode=yes -o ConnectTimeout=10 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /home/puppet/.ssh/id_rsa puppet@$hostIP "chmod +x /tmp/addHost.sh"
ssh -n -o BatchMode=yes -o ConnectTimeout=10 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /home/puppet/.ssh/id_rsa puppet@$hostIP "sudo bash -c /tmp/addHost.sh"
ssh -n -o BatchMode=yes -o ConnectTimeout=10 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /home/puppet/.ssh/id_rsa puppet@$hostIP "sudo /etc/init.d/nagios-nrpe-server restart"


sudo systemctl reload nagios3.service
