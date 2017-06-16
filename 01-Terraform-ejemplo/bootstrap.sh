#!/bin/sh
echo '`ip a | grep eth0 -A 2 | grep "inet" | grep -v inet6 | cut -d " " -f 6`' > /tmp/ifconfig_output.txt
