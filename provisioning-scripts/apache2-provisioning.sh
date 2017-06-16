#!/bin/bash
echo "About to install apache2."
sudo apt-get update
DEBIAN_FRONTEND=noninteractive sudo apt-get -y --force-yes install apache2 libapache2-mod-php5 php5 php5-mysql
sudo sed -i '/Listen/{s/\([0-9]\+\)/8080/; :a;n; ba}' /etc/apache2/ports.conf
sudo sed -i 's/*:80/*:8080/' /etc/apache2/sites-enabled/000-default.conf
sudo systemctl restart apache2
