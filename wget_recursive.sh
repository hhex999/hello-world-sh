#!/usr/bin/env sh

URL=""
echo "URL ?"
read URL
wget --user-agent="aw" --no-cookies --recursive --level=3 --no-parent --convert-links  "$URL" || echo "no URL is given....."
#--continue
#--backup-converted

# -m
# --mirror
# Turn on options suitable for mirroring.  This option turns on recursion and time-stamping, sets infinite recursion depth and keeps FTP directory listings.  It is currently equivalent to -r -N -l inf --no-remove-listing.
# --recursive
# Turn on recursive retrieving.    The default maximum depth is 5.

wget --user-agent="aw" --no-cookies --convert-links -i \
../howtos1.html \

wget --user-agent="aw" --no-cookies --convert-links \
"http://www.faqs.org/docs/minis1.html" \
"http://www.faqs.org/docs/minis2.html" \

wget --user-agent="aw" --no-cookies --convert-links -i \
../minis1.txt \

wget --user-agent="aw" --no-cookies --recursive --level=5 --no-parent --convert-links \
http://www.faqs.org/docs/securing/

http://www.faqs.org/docs/abs/HTML/
http://www.faqs.org/docs/indexb.html

