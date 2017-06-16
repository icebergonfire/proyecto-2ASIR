#!/bin/bash

nodeBaseName="node"

totalNumberOfNodes=$1

nodeCount=1
tmpFiles="/tmp/tfnodes"
cd $tmpFiles

rm -rf $tmpFiles/_node*

while [ $nodeCount -le $totalNumberOfNodes ]
do
	currentNodeName=$nodeBaseName$nodeCount
	currentNodeFilename=$currentNodeName".tf"
	cat header.tf.template | sed "s/#INSTANCE-NAME#/$currentNodeName/g" >> $tmpFiles/_$currentNodeFilename
	cat node.tf.template | sed "s/#INSTANCE-NAME#/$currentNodeName/g" >> $tmpFiles/_$currentNodeFilename
	cat footer.tf.template | sed "s/#INSTANCE-NAME#/$currentNodeName/g" >> $tmpFiles/_$currentNodeFilename
	nodeCount=$((nodeCount+1))
done

cd $tmpFiles
terraform apply

