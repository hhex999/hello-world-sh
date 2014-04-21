#!/usr/bin/env sh

#http://ftp2.ru.freebsd.org/pub/FreeBSD/doc/en_US.ISO8859-1/articles/
#http://ftp2.ru.freebsd.org/pub/FreeBSD/doc/en_US.ISO8859-1/books/

#http://ftp.freebsd.org/pub/FreeBSD/doc/en_US.ISO8859-1/articles/
#http://ftp.freebsd.org/pub/FreeBSD/doc/en_US.ISO8859-1/books/

wget --recursive --no-parent --user-agent=cuteAgent --accept \
*.html-split.tar.bz2,*.ps.bz2,*.txt.bz2 --reject \
*.html-split.tar.zip,*.html.tar.bz2,*.html.tar.zip,*.pdf.bz2,\
*.pdf.zip,*.ps.zip,*.rtf.bz2,*.rtf.zip,*.txt.zip \
http://ftp.freebsd.org/pub/FreeBSD/doc/en_US.ISO8859-1/articles/

wget --recursive --no-parent --user-agent=cuteAgent --accept \
*.html-split.tar.bz2,*.ps.bz2,*.txt.bz2 --reject \
*.html-split.tar.zip,*.html.tar.bz2,*.html.tar.zip,*.pdf.bz2,\
*.pdf.zip,*.ps.zip,*.rtf.bz2,*.rtf.zip,*.txt.zip \
http://ftp.freebsd.org/pub/FreeBSD/doc/en_US.ISO8859-1/books/
