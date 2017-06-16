DEBIAN_FRONTEND=noninteractive sudo apt-get -y --force-yes install haproxy -y
sudo bash -c  'cat <<EOF > /etc/haproxy/haproxy.cfg
global
	daemon
	maxconn 20000
	user    haproxy
	group   haproxy
	log     127.0.0.1       local0
	log     127.0.0.1       local1  notice	

defaults
	mode    http
	log     global
	timeout connect 5000ms
	timeout client  50000ms
	timeout server  50000ms	

listen stats :81
mode http
option httpclose
balance roundrobin
stats enable
stats uri /
stats realm Haproxy\ Statistics

listen apaches :80
	mode http
	stats enable
	stats auth  cda:cda
	balance roundrobin

	# Example of node
	# server uno 172.16.4.25:80 maxconn 128 check
	# These two anchors are used by the terraforming scripts, do not modify by hand!

	#node_list_begin

	#node_list_end

EOF'

sudo cp /vagrant/haproxy-add-host.sh /bin/
sudo chmod +x /bin/haproxy-add-host.sh

sudo service haproxy restart
