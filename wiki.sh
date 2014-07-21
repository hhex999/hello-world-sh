#!/usr/bin/env sh

WIKI_HTML_DIR="html_data"
WIKI_MEDIA_DIR="media"
MEDIA_DATA_TYPES="*.jpg *.JPG *.jpeg *.JPEG *.svg *.SVG *.gif *.GIF *.png *.PNG"
HTML_DATA_TYPES="*.htm *.html"

# 1: media
for m in $(echo "$MEDIA_DATA_TYPES") ; do
mv "$m" "$WIKI_MEDIA_DIR" || echo "==== no media files found, skipping ===="
done

# 2: .htm*
for h in $(echo "$HTML_DATA_TYPES") ; do
mv "$h" "$WIKI_HTML_DIR" || echo "==== no HTML files found, skipping ===="
done

echo ""
echo "========== We are DONE here =========="

