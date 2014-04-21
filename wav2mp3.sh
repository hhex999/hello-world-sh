#!/usr/bin/env sh
#
# for INFILE in `find ./ -type f -iname '*.wav' -or -iname '*.WAV'`;
for INFILE in `find ./ -type f -iname '*.wav' -or -iname '*.WAV'`;
do OUTFILE=`echo $INFILE | sed -e "s/[Ww][Aa][Vv]/mp3/"`
lame -V 8 "${INFILE}" "${OUTFILE}"
done
#
# cdparanoia -B                   # Copy the tracks to wav files in current dir
# lame -b 256 in.wav out.mp3      # Encode in mp3 256 kb/s
# for i in *.wav; do lame -b 256 $i `basename $i .wav`.mp3; done
# oggenc in.wav -b 256 out.ogg    # Encode in Ogg Vorbis 256 kb/s
