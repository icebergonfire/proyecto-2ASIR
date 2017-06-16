#!/bin/bash
sudo debconf-set-selections <<< 'mysql-server mysql-server-5.5/root_password password root'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password root'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server-5.5/root_password_again password root'

DEBIAN_FRONTEND=noninteractive sudo apt-get -y --force-yes install mysql-server
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
sudo service mysql restart

