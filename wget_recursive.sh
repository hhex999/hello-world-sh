#!/usr/bin/env sh

URL=""
echo "the URL ?"
read URL
wget --no-cookies --user-agent="w" --recursive --level=1 --no-parent "$URL"
