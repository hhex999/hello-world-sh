#!/usr/bin/env sh
#
# oggenc -q 6 (-1 = very low; 10 = very high quality; -q 6 = VBR192k)
#
INPUTFILE=""
OUTFILE=""
OUTFLAC=""
OUTWAV=""
OUTOGG=""
INDIR="./"
OUTDIR="./"
#
for INPUTFILE in `find ${INDIR} -type f -iname '*.m4a' -or -iname '*.M4A'`
do OUTFLAC=`echo ${INPUTFILE} | sed -e "s/[Mm][4][Aa]/flac/"`
ffmpeg -y -i ${INPUTFILE} -q 5 ${OUTFLAC}
done
