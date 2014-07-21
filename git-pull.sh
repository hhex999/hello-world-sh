#!/usr/bin/env sh

for i in * ; do
  if test -d "$i" ; then
  cd "$i" && git pull && cd ..
  fi
done

echo ""
echo "we are DONE here......................................"
echo ""

