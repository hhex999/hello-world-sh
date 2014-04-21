#!/usr/bin/env sh

#for i in `find ./ -type f -iname '*.mp4' -or -iname '*.MP4'` ; do
#OUTFLAC=`echo ${INPUTFILE} | sed -e "s/[Mm][Pp][4]/flac/"`
#ffmpeg -y -i ${INPUTFILE} -acodec flac -aq 5 -vn -sn ${OUTFLAC}
#done

for i in *.mp4 *.webm *.flv ; do
ffmpeg -y -i "$i" -vn -sn "${i}.flac"
done

oggenc -q 4 *.flac
