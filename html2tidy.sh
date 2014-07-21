#!/usr/bin/env sh

#echo "Enter the full PATH"
#read DIR

for i in *.htm *.html
do
tidy -config ~/tidy-html-conf "$i" > "${i}.tidy.html"
done

