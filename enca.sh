#!/bin/sh

#enca -L ru c_3.html
#enconv -L ru -x UTF-8 c_3.html

for i in *.htm *.html ; do
enconv -L ru -x UTF-8 "$i"
done

