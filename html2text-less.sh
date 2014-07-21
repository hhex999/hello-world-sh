#!/usr/bin/env sh

#Usage: html2text [(filename|url) [encoding]]

#for f in *.htm *.html ; do
#html2text "$f" > "${f}.md"
#done

f="basename"
html2text %f | less

