#!/usr/bin/env sh

URL=""
echo "enter URL and press ENTER"
read URL
exec w3m -no-cookie "$URL"
