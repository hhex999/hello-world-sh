#!/usr/bin/env sh

for I in *
do
tar -caf "${I}.tar.xz" "$I"
done
