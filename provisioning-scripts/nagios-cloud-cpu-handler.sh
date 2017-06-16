#!/bin/sh
# Slightly modified version of cpu-load-handler.
# Will generously spin up many nodes since the goal is to have significant capacity to spare.

case "$1" in
	localhost)
		exit 0
	;;
esac

lockfile -r 0 /tmp/terraforming.lock || exit 0

currentNumberOfNodes=`wc -l /tmp/active-nodes.list | cut -d " " -f 1`
echo `date` >> /tmp/state
echo "$@" >> /tmp/state

case "$2" in
OK)
	echo "$1 IS OK" >> /tmp/service.state
	;;
WARNING)
	# We spin-up two nodes.
	nodeCount=$((nodeCount+2))
	/bin/terraform-control.sh  $nodeCount >> /tmp/terraforming.log
	;;
UNKNOWN)
	;;
CRITICAL)
	echo "$1 CRITICAL" >> /tmp/service.state
	case "$3" in

	SOFT)
		# This looks bad, better 4 more nodes.
		nodeCount=$((nodeCount+4))
		/bin/terraform-control.sh  $nodeCount >> /tmp/terraforming.log
		case "$4" in

		# We being chocked by our own success, we better fix that.

	HARD)
		nodeCount=$((nodeCount+10))
		/bin/terraform-control.sh  $nodeCount >> /tmp/terraforming.log
		;;
	esac
	;;
esac

rm -rf /tmp/terraforming.lock

exit 0
