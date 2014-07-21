#!/usr/bin/env sh

for i in * ; do
  if [ -d "$i"  ] ; then
  rm -rf "$i"
  else
  ls -l "$i"
  fi
done

echo "..........done!"
