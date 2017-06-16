#!/bin/bash
ownIP=`ip -o -4 addr | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v -E "*255$" | grep -v 10.0.2.15 | grep -v 255.255.255.0 | grep -v 127.0.0.1 | grep -v 255.0.0.0`
netmask="/24"
localNetwork="$ownIP$netmask"
sudo nmap -sF -p 22,5666 $localNetwork | grep -B 5 "5666/tcp open|filtered nrpe" | grep -B 4 -A 1 "22/tcp   open|filtered ssh" | awk '/^Nmap scan report for/{print $5}' > /tmp/hosts-with-ssh-open.list
sudo sed -i "/$ownIP/d" /tmp/hosts-with-ssh-open.list
while IFS= read -r potentialNodeIP
do
  grep  "$potentialNodeIP" /tmp/active-nodes.list
  if ! grep -q "$potentialNodeIP" /tmp/active-nodes.list;
  	then
  		echo "Trying node: $potentialNodeIP..."
   		ssh -n -o BatchMode=yes -o ConnectTimeout=5 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /home/puppet/.ssh/id_rsa puppet@$potentialNodeIP 'exit' && /bin/add-node.sh $potentialNodeIP $potentialNodeIP && echo $potentialNodeIP >> /tmp/active-nodes.list
  fi
  
done < "/tmp/hosts-with-ssh-open.list"

while IFS= read -r nodeIP
do
	echo "Testing node: $nodeIP..."
	if ! ping -c 1 $nodeIP -W 1;
		then # Node is down
			/bin/remove-node.sh $nodeIP
			grep -v $nodeIP /tmp/active-nodes.list > /tmp/active-nodes.list.tmp
			mv /tmp/active-nodes.list.tmp /tmp/active-nodes.list
  fi
done < "/tmp/active-nodes.list"
