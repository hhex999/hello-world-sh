#!/usr/bin/env sh

for i in * ; do
  if [ -d "$i"  ] ; then
  chmod +x "$i"
  else
  chmod -x "$i"
  fi
done

echo "..........done!"
