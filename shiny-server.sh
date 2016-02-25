#!/bin/sh

# Make sure the directory for individual app logs exists
mkdir -p /var/log/shiny-server
chown shiny.shiny /var/log/shiny-server

for f in /docker-entrypoint-init.d/*; do
	case "$f" in
		*.sh)	echo "$0: running $f"; . "$f" ;;
		*.R)	echo "$0: running $f"; R -f "$f" ;;
	esac
done

exec shiny-server >> /var/log/shiny-server.log 2>&1
