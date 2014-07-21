#!/usr/bin/env sh

#Usage: html2text [(filename|url) [encoding]]
#html2text "$f" > "${f}.md" || echo "no html files given... aborting."

for f in *.htm *.html ; do
html2text-3.3 "$f" > "${f}.md" || echo "no \"$f\" files given... aborting."
done

echo ""
echo "========== we are DONE here =========="
echo ""

