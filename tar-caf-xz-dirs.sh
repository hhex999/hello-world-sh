#!/usr/bin/env sh

for i in * ; do
  if test -d "$i" ; then
  tar -caf "${i}.tar.xz" "$i" && rm -rf "$i"
  fi
done

