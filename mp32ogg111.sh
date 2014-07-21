#!/usr/bin/env sh
#
# hhex999
# created on Fri Jan 18 00:02:20 MSK 2013
# inspired by `ape2ogg` of Zakhary Akulov
#

QUALITY=5
INPUTFILE=
OUTWAV=
INDIR="./"
OUTDIR="./"

while test $# -gt 0; do
	case "$1" in
	--vers | --versi | --versio | --version)
	echo 'mp32ogg 0.1'
	printf $"Copyright (C) %s Free Software Foundation, Inc.
	This is free software; see the source for copying conditions. There is NO
	warranty; not even for MERCHANTABILITY of FITNESS FOR A PARTICULAR PURPOSE.
	" "2013"
	printf $"Written by hhex999"
	printf $"Inspired by `ape2ogg` of Zakhary Akulov"
	printf $"Feel free to email me about possible bugs at %s
	" "hhex999 at gmail dot com"
	exit 0
	;;
	
	--h | --he | --hel | --help)
	echo $"Usage: `basename $0` [-q number] [-i dir] [-o dir] [-h]
	-q				quality, default 5
	-i dir			input catalog
	-o dir			output catalog
	-h, --help		watch help and quit
	--version		watch version and quit"
	exit 0
	;;
	
	-v | --v | --ve | --ver)
	echo >&2 $"`basename $0` : cannot know that option \`$1'"
	exit 1
	;;
	
	-q)
	QUALITY="$2"
	shift 2
	;;
		
	-i)
	INDIR="$2"
	shift 2
	;;
	
	-o)
	OUTDIR="$2"
	shift 2
	;;
	
	--)		# stoping
	shift; break
	;;
	
	-*)
	echo >&2 "`basename $0` :" $"cannot know that option" "\`$1'"
	echo >&2 $"type '`basename $0` --help' for getting help."
	exit 1
	;;
	
	*)
	break
	;;
	
	esac
	done
	
	for INPUTFILE in `find ${INDIR} -type f -iname '*.mp3' -or -iname '*.MP3'`
	do OUTWAV=`echo $INPUTFILE | sed -e "s/[Mm][Pp][3]/wav/"`
	lame --decode "${INPUTFILE}" "${OUTWAV}"
	done
	
	for OUTWAV in `find ${INDIR} -type f -iname '*.wav'`
	do
	oggenc --resample 44100 -q "${QUALITY}" "${OUTWAV}" -o "${OUTDIR}/`echo ${OUTWAV} | sed -e "s/wav/ogg/"`"
	done
