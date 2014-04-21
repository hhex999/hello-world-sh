#!/usr/bin/env sh

#echo "Enter the full PATH"
#read DIR

for i in *.htm *.html;
do
tidy -config /home/hhex/tidy-html-conf "$i" > "${i}_tidy.html";
rm "*.html_tidy.html";
done
