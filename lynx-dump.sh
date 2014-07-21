#!/usr/bin/env sh

for i in *.htm *.html ; do
  lynx -dump "$i" > "${i}.txt"
done

