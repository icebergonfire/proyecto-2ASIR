#!/bin/sh
echo `date` >> /tmp/state
echo "$@" >> /tmp/state

# What state is the service in?
case "$2" in
OK)
	# The service just came back up, so don't do anything...
	echo "$1 IS OK" >> /tmp/service.state
	;;
WARNING)
	# We don't really care about warning states, since the service is probably still running...
	echo "$1 WARNING" >> /tmp/service.state
	;;
UNKNOWN)
	# We don't know what might be causing an unknown error, so don't do anything...
	;;
CRITICAL)
	echo "$1 CRITICAL" >> /tmp/service.state
	case "$3" in

	SOFT)
		echo "       BUT SOFT" >> /tmp/service.state
		case "$4" in

		# Wait until the check has been tried 3 times before restarting the web server.
		# If the check fails on the 4th time (after we restart the web server), the state
		# type will turn to "hard" and contacts will be notified of the problem.
		# Hopefully this will restart the web server successfully, so the 4th check will
		# result in a "soft" recovery.  If that happens no one gets notified because we
		# fixed the problem!
		3)
			echo "$1 IS ALMOST HARD" >> /tmp/service.stat
			;;
			esac
		;;

		# At this point there is no hope, we are surely being hug to death by the Internet.
		# We start the scaling up process.
	HARD)
		echo "$1 METAPOED" >> /tmp/service.state
		echo "DEPLOY THE TERRAFORMS" >> /tmp/service.state
		/bin/init-to-the-cloud.sh

		;;
	esac
	;;
esac
exit 0
