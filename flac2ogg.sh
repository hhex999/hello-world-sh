#!/usr/bin/env sh

#for INPUT in *.wv *.WV
#do
#OUTPUT=`echo "$INPUT" | sed -e "s/[Ww][Vv]/flac/"`
#ffmpeg -y -i "$INPUT" "$OUTPUT"
#done

for INPUT in *.flac
do
oggenc -q 6 "$INPUT"
done

#oggenc -q 6 (-q 1 = very low; -q 10 = very high; -q 6 = VBR192k)
#for INPUT in `find ./ -type f -iname '*.mp3' -or -iname '*.MP3'`

#######################################################################

#for i in *.mp3; do ffmpeg -i $i `basename $i .mp3`.flac; done
#for i in *.flac; do oggenc -q 6 $i; done
#for i in *.wav; do lame -b 256 $i `basename $i .wav`.mp3; done
#for i in *.wav; do lame -V 8 $i `basename $i .wav`.mp3; done
#for i in *.mp3; do lame --decode $i `basename $i .mp3`.wav; done

#######################################################################

#mkdir new-png; for f in *.jpg;
#do convert -colorspace GRAY -resize 1024 "$f" "new-png/${f%.jpg}.png";
#done

#######################################################################

#cdparanoia -B                   # Copy the tracks to wav files in current dir
#lame -b 256 in.wav out.mp3      # Encode in mp3 256 kb/s
#for i in *.wav; do lame -b 256 $i `basename $i .wav`.mp3; done
#oggenc in.wav -b 256 out.ogg    # Encode in Ogg Vorbis 256 kb/s
#oggenc -q 6 "${OUTFILE}" -o "${OUTDIR}/`echo ${OUTWAV} | sed -e "s/wav/ogg/"`"
