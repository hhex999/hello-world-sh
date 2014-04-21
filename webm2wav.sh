#!/usr/bin/env sh
#
#for INPUTFILE in `find ./ -type f -iname '*.mp4' -or -iname '*.MP4'`
#do OUTWAV=`echo ${INPUTFILE} | sed -e "s/[Mm][Pp][4]/wav/"`
#ffmpeg -y -i ${INPUTFILE} -vn -sn ${OUTWAV}
#done
#
#
for INPUTFILE in `find ./ -type f -iname '*.webm' -or -iname '*.WEBM'`
do OUTWAV=`echo ${INPUTFILE} | sed -e "s/[Ww][Ee][Bb][Mm]/wav/"`
ffmpeg -y -i ${INPUTFILE} -vn -sn ${OUTWAV}
done
