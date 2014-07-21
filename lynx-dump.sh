#!/usr/bin/env sh

for i in *.htm *.html ; do
  lynx -dump "$i" > "${i}.txt" || echo "operation failed..."
done

rm \*.html.txt
echo "Anyway, we are DONE, so check out"
ls -lh

