#! /bin/sh

for i in * ; do
mv "$i" "${i}.html"
done

echo ""
echo "========== we are DONE here =========="

