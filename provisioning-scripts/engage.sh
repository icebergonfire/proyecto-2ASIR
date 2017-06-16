# If we are here, it means our local DC is overflowing with visitors.
# We are going to generously spawn many nodes to deal with capacity issues.
# After they finish spinning up, we will update proyecto.josuealvarezmoreno.es to point to us.
chmod -x /etc/cron.d/addnodes
/bin/terraform-control.sh 1
/bin/scan-local-network-for-nodes.sh
/bin/update-dns.sh
chmod +x /etc/cron.d/addnodes
