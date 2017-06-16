DEBIAN_FRONTEND=noninteractive sudo apt-get install -y --force-yes build-essential nagios-nrpe-server nagios-plugins
sudo sed -i "s/.*dont_blame_nrpe.*/dont_blame_nrpe=1/" /etc/nagios/nrpe.cfg
sudo sed -i "s/log_facility.*/log_facility=syslog/" /etc/nagios/nrpe.cfg
sudo bash -c 'echo "command[check_load]=/usr/lib/nagios/plugins/check_load -w 0.5,0.4,0.3, -c 0.6,0.5,0.4" >> "/etc/nagios/nrpe_local.cfg"'
sudo service nagios-nrpe-server restart

