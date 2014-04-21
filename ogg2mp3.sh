#!/usr/bin/env sh

for INPUT in *.ogg *.OGG
do
OUTPUT=`echo "$INPUT" | sed -e "s/[Oo][Gg][Gg]/mp3/"`
ffmpeg -y -i "$INPUT" -q:a 3 "$OUTPUT"
done

