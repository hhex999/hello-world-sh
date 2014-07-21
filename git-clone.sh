#!/bin/sh

URL="0"
while test -n "$URL" ; do
  echo "get me URL (zerolength is stop)"
  read URL
  if test -n "$URL" ; then
    git clone "$URL"
    else
    echo "no URLs given; exit"
  fi
done

