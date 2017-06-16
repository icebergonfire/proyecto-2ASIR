#!/bin/bash
cloudMaster="34.204.91.248"


# We allow the cloud to kick in on proyecto.josuealvarezmoreno.es as soon as it is ready.
sudo service ddclient stop

# Here we would call helper scripts to make sure the cloud and the local-cache are in sync

# After we are fully ready, we hand over the baton to the cloud.

ssh -n -o BatchMode=yes -o ConnectTimeout=5 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /vagrant/provisioning-key admin@$cloudMaster "sudo bash -c /bin/engage.sh > /tmp/engage.log"
