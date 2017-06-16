#!/bin/sh
sudo locale-gen es_ES.UTF-8

# Timezone settings
echo "Europe/Madrid" | sudo tee /etc/timezone
sudo dpkg-reconfigure --frontend noninteractive tzdata


sudo apt-get update
sudo apt-get -y install screen mosh stress cpulimit
sudo useradd -m -s /bin/bash -p CByEBoOJ2nVRg puppet
sudo echo "puppet:puppet" | /usr/sbin/chpasswd
sudo adduser puppet sudo
echo "puppet ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/puppet

sudo mkdir /home/puppet/.ssh/
sudo cp /vagrant/provisioning-key /home/puppet/.ssh/id_rsa
sudo bash -c 'echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDeXKNu2ozFXSOo++qEMWtT9v3Sl62OsvxIn4fuq12Vaz+OMnH/8msqE26r4wugvVNzdx+mj/ghxDE4hJgmb7lcPYjXUJkWrmvEikez4rlWpqq62OnaQR1+tfNEvYAf0AShKYpFHDfAVLzAxGjKNL48zFocClwypLxTJKcRI4nIkBRzQXLsq56LNGYA3sIq7Na3fyuSFhE2GAxkwxJO3fBOBTPFb9OgU3Vbl6Alh3lvGbd2rExVgrsYOqUuosO6r1CvkCoZDODofps9vfnkvzW1IkdGP7VyAcf9Vos9a1yt9J1dKtyq0MmlilJSNbQLb/t8pwXCIW3/iG1D1Bo5bmvF sterling@Pegasus" >> /home/puppet/.ssh/authorized_keys'

sudo chown -R puppet:puppet /home/puppet/.ssh
sudo chmod +x /home/puppet/.ssh
sudo chmod 600 -R /home/puppet/.ssh/*

sudo service ssh restart
