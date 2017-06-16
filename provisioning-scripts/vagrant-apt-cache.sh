#!/bin/bash
hostname=`hostname`

if [[ $hostname == "node"* ]]; then
	echo "This is a node." >> /tmp/cache.status
	sudo tar  -xvf /vagrant/cache/node/apt-cache.tar.gz -C /var/cache/
else
	echo "This is the master." >> /tmp/cache.status
	sudo tar  -xvf /vagrant/cache/main/apt-cache.tar.gz -C /var/cache/
fi
