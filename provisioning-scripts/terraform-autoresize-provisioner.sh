#!/bin/bash
mkdir /tmp/tmp/
cd /tmp/tmp/
sudo apt-get install unzip
wget https://releases.hashicorp.com/terraform/0.9.8/terraform_0.9.8_linux_amd64.zip
unzip terraform_0.9.8_linux_amd64.zip
chmod +x terraform
sudo cp terraform /bin/
mkdir /tmp/tfnodes


sudo sed -i "s@/home/sterling/Dropbox/media/clases/proyecto/provisioning-scripts@/vagrant@" /vagrant/variables.tf

#sudo bash -c 'cat <<EOF > /vagrant/variables.tf
# variable "provisioning-folder" {
#	type = "string"
#	default = "/vagrant"
#}
#EOF
#'

sudo cp /vagrant/*tf /vagrant/*tf.template  /tmp/tfnodes/

sudo cp /vagrant/engage.sh /vagrant/terraform-control.sh /vagrant/terraform-node-generator.sh /vagrant/nagios-cloud-cpu-handler.sh /bin/
sudo chmod +x  /bin/engage.sh  /bin/terraform-control.sh /bin/terraform-node-generator.sh /bin/nagios-cloud-cpu-handler.sh
