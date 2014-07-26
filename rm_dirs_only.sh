#!/usr/bin/env sh

for i in * ; do
  if [ -d "$i"  ] ; then
  rm -rf "$i"
  else
  ls -l
  fi
done

echo "..........done!"

