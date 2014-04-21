#!/usr/bin/env sh

URL=""
echo "Enter URL and press Enter"
read "$URL"
lynx -cache=100 -cookies -editor=/usr/bin/vim -image_links -print -scrollbar -short_url -verbose -useragent=Lynx "$URL"
