#!/usr/bin/env sh

URL=""
echo "Which is URL?"
read $URL

# -anonymous=on
# -cache=100
# -cookies=off
# -editor=/usr/bin/vim
# -image_links=on
# -print=on
# -scrollbar=on
# -short_url=on
# -verbose=on
# -useragent=Lynx

lynx "$URL"
