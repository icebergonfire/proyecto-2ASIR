# If we are here, it means our local DC is overflowing with visitors.
# We are going to generously spawn many nodes to deal with capacity issues.
# After they finish spinning up, we will update proyecto.josuealvarezmoreno.es to point to us.

/bin/terraform-node-generator.sh 1 > /tmp/terraforming.status

/bin/update-dns.sh >> /tmp/ddclient.status && echo "Up and running."

