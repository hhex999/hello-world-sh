#!/usr/bin/env sh

URLS=""
echo "Give me URL links: "
read URLS
curl "$URLS"
echo done

#curl --user-agent agent --connect-timeout 20 --retry 100 --retry-delay 3 --remote-name  -C "$URLS"
#--remote-name-all
