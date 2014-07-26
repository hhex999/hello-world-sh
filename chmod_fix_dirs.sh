#!/usr/bin/env sh

for i in * ; do
  if test -d "$i" ; then
  chmod +x "$i"
  else
  chmod -x "$i"
  fi
done

echo "=== we are DONE ==="
