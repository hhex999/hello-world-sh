#!/usr/bin/env sh
#
#for INPUTFILE in `find ./ -type f -iname '*.mp4' -or -iname '*.MP4'`
#do OUTWAV=`echo ${INPUTFILE} | sed -e "s/[Mm][Pp][4]/wav/"`
#ffmpeg -y -i ${INPUTFILE} -vn -sn ${OUTWAV}
#done
#
for INPUTFILE in `find ./ -type f -iname '*.wav' -or -iname '*.WAV'`
do OUTOGG=`echo ${INPUTFILE} | sed -e "s/[Ww][Aa][Vv]/ogg/"`
oggenc -q 4 ${INPUTFILE} -o ${OUTOGG}
done
