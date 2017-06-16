sudo DEBIAN_FRONTEND=noninteractive apt-get -y install nagios-nrpe-server nagios-plugins nagios3 git python-pip sendemail nagios-nrpe-plugin
sudo service nagios3 stop
sudo dpkg-statoverride --update --add nagios www-data 2710 /var/lib/nagios3/rw
sudo dpkg-statoverride --update --add nagios nagios 751 /var/lib/nagios3
sudo service nagios3 start
sudo htpasswd -b -c /etc/nagios3/htpasswd.users nagiosadmin nagios

sudo sed -i 's/check_external_commands=0/check_external_commands=1/' /etc/nagios3/nagios.cfg
sudo sed -i 's/root@localhost/zozue49+nagios@gmail.com/' /etc/nagios3/nagios.cfg
sudo sed -i 's/interval_length=.*/interval_length=1/g' /etc/nagios3/nagios.cfg
echo '$USER4$=zozue49' | sudo tee -a /etc/nagios3/resource.cfg
echo '$USER5$=alpymzhkvvfeffci' | sudo tee -a /etc/nagios3/resource.cfg

sudo ln -s /etc/nagios3/apache2.conf /etc/apache2/sites-available/nagios.conf
sudo a2ensite nagios
sudo sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf
sudo service apache2 restart



sudo cp /vagrant/nagios-cpu-handler.sh /vagrant/nagios-add-host.sh /bin/
sudo chmod +x /bin/nagios-*.sh

sudo bash -c 'cat <<EOF > /etc/nagios3/conf.d/hostgroup-nodes.cfg

define hostgroup {
        hostgroup_name  nodes
                alias           Dynamic nodes
                members 		*
        }
EOF'

sudo bash -c 'cat <<EOF > /etc/nagios3/conf.d/nodes.template

define host{
        use                     generic-host            ; Name of host template to use
        host_name               #NODE-HOSTNAME#
        alias                   #NODE-HOSTNAME#
        address                 #NODE-IP#
        }

EOF'


sudo bash -c 'cat <<EOF > /etc/nagios3/conf.d/resizing-commands.cfg

define command{

command_name nagios-cpu-handler
command_line /bin/nagios-cpu-handler.sh \$HOSTADDRESS$ \$SERVICESTATE$ \$SERVICESTATETYPE$ \$SERVICEATTEMPT\$
} 
EOF'

sudo bash -c 'cat <<EOF >> /etc/nagios3/commands.cfg

define command {
    command_name    check_remote_load
    command_line \$USER1\$/check_nrpe -H \$HOSTADDRESS\$ -c check_load
}

EOF'

sudo bash -c 'cat <<EOF >> /etc/nagios3/conf.d/services_nagios2.cfg
define service {
        hostgroup_name                  nodes
        service_description             Load
        event_handler                   nagios-cpu-handler
        check_command                   check_remote_load
        use                             generic-service
        notification_interval           0 ; set > 0 if you want to be renotified
}
EOF'


cd /etc/nagios3/conf.d/


sudo service nagios-nrpe-server restart
sudo service nagios3 restart


