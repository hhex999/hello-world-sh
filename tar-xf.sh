#!/usr/bin/env sh

for i in * ; do
  if test -f "$i" ; then
  tar -xf "$i" && rm -rf "$i"
  fi
done

