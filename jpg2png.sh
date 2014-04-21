#!/usr/bin/env sh

mkdir new-png; for f in *.jpg; do 
convert -colorspace GRAY -resize 1024 "$f" "new-png/${f%.jpg}.png"; 
done
#######################################################################
#
#mkdir new-jpg; for f in *.png; 
#do convert -quality 80 "$f" "new-jpg/${f%.png}.jpg"; 
#done
#######################################################################
#
#for IN_JPG in `find ./ -type f -iname '*.jpg' -or -iname '*.JPG'`
#do OUT_PNG=`echo $IN_JPG | sed -e "s/[Jj][Pp][Gg]/png/"`
#convert -colorspace GRAY -resize 50% "${IN_JPG}" "${OUT_PNG}"
#done
#
#EOF
#convert -resize 50% -colorspace Gray "${IN_PNG}" "${OUT_JPG}"
#
# -compress type
# -quality value
# -grayscale method 
# -monochrome
# -auto-level
# -equalize
# -level value
# -normalize
