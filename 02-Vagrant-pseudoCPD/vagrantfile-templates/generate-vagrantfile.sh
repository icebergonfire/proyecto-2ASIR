#!/bin/bash

masterName="main"
read -e -i "$masterName" -p "What is the name of the master node: " input
masterName="${input:-$masterName}"

nodeBaseName="node"
read -e -i "$nodeBaseName" -p "What is the base name of the nodes: " input
nodeBaseName="${input:-$nodeBaseName}"

totalNumberOfNodes="2"
read -e -i "$totalNumberOfNodes" -p "How many nodes should be spun up?: " input
totalNumberOfNodes="${input:-$totalNumberOfNodes}"

rm -rf /tmp/Vagrantfile
cat header.template >> /tmp/Vagrantfile
cat main.template | sed "s/#MAIN#/$masterName/g" >> /tmp/Vagrantfile

nodeCount=1
while [ $nodeCount -le $totalNumberOfNodes ]
do
	currentNodeName=$nodeBaseName$nodeCount
	cat node.template | sed "s/#NODE#/$currentNodeName/g" >> /tmp/Vagrantfile
	nodeCount=$((nodeCount+1))
done

cat footer.template >> /tmp/Vagrantfile
