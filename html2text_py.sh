#!/usr/bin/env sh

for f in *.html; 
do 
html2text "$f" > "${f}".md;
done
