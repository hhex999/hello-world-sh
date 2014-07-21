#!/usr/bin/env sh

#*********************************************************************
# сборка gajim и python-nbxmpp из Mercurial репозитория
#*********************************************************************

# Установлен ли у нас mercurial -- он нам понадобится для
# скачивания исходников (не релизов, а dev ветки разработки) из
# репозитория hg.gajim.org
sudo apt-get install mercurial

# Set certificate fingerprint: Add the folowing fingerprint for
# server hg.gajim.org into the ~/.hgrc Mercurial configuration file.
#[hostfingerprints]
#hg.gajim.org = 38:8d:67:e8:ce:76:7f:75:3d:ed:9b:b2:4a:06:aa:71:4c:14:fe:da

# исходя из комментария выше ^^^ взятого на где-то на ... http://hg.gajim.org
# нам нужно занести "отпечаток сертификата" для сервера hg.gajim.org
# в ~/.hgrc конфигурационный файл Mercurial, делаем :

echo "[hostfingerprints]" >> ~/.hgrc
echo "hg.gajim.org = 38:8d:67:e8:ce:76:7f:75:3d:ed:9b:b2:4a:06:aa:71:4c:14:fe:da" >> ~/.hgrc

# если при попытке соединения с сервером команда `hg clone https://адрес`
# выдаст ошибку вроде этой :

# abort: certificate for hg.gajim.org has unexpected fingerprint
# 77:3b:82:49:eb:e0:92:b5:fd:46:af:fd:50:50:b7:9b:cd:55:9d:8a

# то тогда видимо сменился "отпечаток сертификата" сервера ((у меня
# так и было, выдало ошибку)) и нам нужно заменить строчку в конфиге
# ~/.hgrc с этой :
hg.gajim.org = 38:8d:67:e8:ce:76:7f:75:3d:ed:9b:b2:4a:06:aa:71:4c:14:fe:da
# на эту :
hg.gajim.org = 77:3b:82:49:eb:e0:92:b5:fd:46:af:fd:50:50:b7:9b:cd:55:9d:8a

# можно сделать этими командами :
# первая команда очистит целиком файл конфига ~/.hgrc
echo "" > ~/.hgrc

# остальные две команды занесут 2 строчки в пустой конфиг :
echo "[hostfingerprints]" >> ~/.hgrc
echo "hg.gajim.org = 38:8d:67:e8:ce:76:7f:75:3d:ed:9b:b2:4a:06:aa:71:4c:14:fe:da" >> ~/.hgrc

# ну и пробуем получить исходники для python-nbxmpp :

# python-nbxmpp is a Python library that provides a way for Python
# applications to use Jabber/XMPP networks in a non-blocking way.
# This library is initialy a fork of xmpppy one, but using
# non-blocking sockets. You can also clone the mercurial repository
# at ​https://hg.gajim.org/python-nbxmpp

# переход в директорию ~/build
cd ~/build
# запуск утилиты Mercurial для клонирования дерева исходников python-nbxmpp
hg clone https://hg.gajim.org/python-nbxmpp python-nbxmpp
# это создаст в директории ~/build директорию python-nbxmpp с исходным
# кодом

# далее создадим архив с исходным кодом на всякий случай, чтобы потом
# можно было быстро распаковать и использовать, а не клонировать каждый
# раз заново :

# переход в директорию на всякий случай
cd ~/build
# создание архива
tar -caf python-nbxmpp.tar.xz python-nbxmpp

# теперь можно собрать python-nbxmpp
# переход в директорию
cd python-nbxmpp
# и собственно установка в систему
sudo python setup.py install

# клонируем дерево исходного кода для gajim?
# переход в директорию сборки
cd ~/build
# клонируем gajim в альтернативную директорию gajim-mercurial на всякий случай
hg clone https://hg.gajim.org/gajim gajim-mercurial

# итак, нам бы сделать архив-бэкап склонированного репозитория
tar -caf gajim-mercurial.tar.xz gajim-mercurial

# ну и судя комментариям на том же hg.gajim.org
# если у нас дерево исходного кода из репозитория Mercurial (hg.gajim.org)
# а не архив, скачанный с http://gajim.org
# то мы можем запустить gajim не собирая его прямо из директории с
# исходным кодом
~/build/gajim-mercurial/launch.sh -p perfilhg
# или так
~/build/gajim-mercurial/launch.sh -p hg
# судя коментарию :
# OK. That is also possible but you should avoid mixing the config file.
#./launch.sh -p hg
# this creates a config.hg (eg profile hg)
# -p что-то на конце это вроде указания gajim создавать разные профили
# конфигов для gajim
# ....it creates a new profile to avoid interferences between any
# ....existing profile. muzzol

#*********************************************************************
#*********************************************************************
#*********************************************************************


#*********************************************************************
# отсюда начинается сбока gajim из релизного архива
# в нашем случае это ( gajim-0.16-rc2.tar.gz )
# Я тут пока не дописал, чуть позже допишу
# тут еще надо будет с зависимостями со всеми разобраться (что куда зачем)
#*********************************************************************

#gajim-0.16-rc2.tar.gz

# кстати, эти зависимости, что мы в прошлый раз устанавливали, я бы их
# все удалил и установил заново только те, что нужны для сборки gajim
#    Runtime Requirements
#  * python2.5 or higher
#  * pygtk2.22 or higher
#  * python-nbxmpp
#
#    Compile-time Requirements
#  * intltool (>= 0.40.1)
#
# так что поступим так : 
# sudo apt-get install intltool python-gtk2-dev python-xmpp python-pyxmpp

sudo apt-get remove  intltool python-gtk2-dev python-xmpp python-pyxmpp
sudo apt-get install intltool python-gtk2-dev

#*********************************************************************


















cd
mkdir ~/build

cd ~/build
tar -xf gajim-0.16-rc2.tar.gz
cd ~/build/gajim-0.16-rc2
./configure --prefix=/usr/local
make
sudo make install && sudo ldconfig

cd ~/build/gajim-0.16-rc2
sudo make uninstall && sudo ldconfig

ls -l /usr/local/bin/
cd ~/build && rm -rf gajim-0.16-rc2


 #1. tar jxvf gajim-version.tar.bz2
 #2. cd gajim
 #3. ./configure
 #4. make (builds translations)
 #5. su -c make install

#To specify where to install do:
    #./configure --prefix=custom_path

python - interactive high-level object-oriented language (default version)
python2.7 - Interactive high-level object-oriented language (version 2.7)
python2.7-dev - Header files and a static library for Python (v2.7)
python3 - interactive high-level object-oriented language (default python3 version)
python3-all-dev - package depending on all supported Python 3 development packages
python3.4 - Interactive high-level object-oriented language (version 3.4)
python3.4-dbg - Debug Build of the Python Interpreter (version 3.4)
python3.4-dev - Header files and a static library for Python (v3.4)
python3.4-doc - Documentation for the high-level object-oriented language Python (v3.4)
python3.4-examples - Examples for the Python language (v3.4)
python3.4-minimal - Minimal subset of the Python language (version 3.4)

python-gtk2-dev - GTK+ bindings: devel files

python-xmpp - Python library for communication with XMPP (Jabber) servers
python-pyxmpp - XMPP and Jabber implementation for Python
python-pyxmpp-doc - XMPP and Jabber implementation for Python (documentation)
python-sleekxmpp - Python XMPP (Jabber) Library Implementing Everything as a Plugin
python-wokkel - collection of enhancements for Twisted
python3-sleekxmpp - Python XMPP (Jabber) Library Implementing Everything as a Plugin

intltool - Utility scripts for internationalizing XML

python3-openssl - Python 3 wrapper around the OpenSSL library
python-openssl - Python 2 wrapper around the OpenSSL library
python-openssl-dbg - Python 2 wrapper around the OpenSSL library (debug extension)
python-openssl-doc - Python wrapper around the OpenSSL library (documentation package)
python3-openssl - Python 3 wrapper around the OpenSSL library
python3-openssl-dbg - Python 3 wrapper around the OpenSSL library (debug extension)

python-pyasn1 - ASN.1 library for Python (Python 2 module)
python-pyasn1-modules - Collection of protocols modules written in ASN.1 language
python3-pyasn1 - ASN.1 library for Python (Python 3 module)

libcrypto++-dev - General purpose cryptographic library - C++ development
libcrypto++-doc - General purpose cryptographic library - documentation
libcrypto++-utils - General purpose cryptographic library - utilities and data files
libcrypto++9 - General purpose cryptographic library - shared library
libcrypto++9-dbg - General purpose cryptographic library - debug symbols
python-crypto - cryptographic algorithms and protocols for Python
python-crypto-dbg - cryptographic algorithms and protocols for Python (debug extension)
python-crypto-doc - cryptographic algorithms and protocols for Python (documentation)
python-itsdangerous - Various helpers to pass trusted data to untrusted environment - python 2.x
python-m2crypto - a crypto and SSL toolkit for Python
python3-crypto - cryptographic algorithms and protocols for Python 3
python3-crypto-dbg - cryptographic algorithms and protocols for Python 3 (debug extension)

libxss-dev - X11 Screen Saver extension library (development headers)
libxss1 - X11 Screen Saver extension library
libxss1-dbg - X11 Screen Saver extension library (debug package)

dbus-x11 - simple interprocess messaging system (X11 deps)
dbus - simple interprocess messaging system (daemon and utilities)
libdbus-1-3 - simple interprocess messaging system (library)
libdbus-1-dev - simple interprocess messaging system (development headers)
libdbus-glib-1-2 - simple interprocess messaging system (GLib-based shared library)
libdbus-glib-1-2-dbg - simple interprocess messaging system (GLib library debug symbols)
libdbus-glib-1-dev - simple interprocess messaging system (GLib interface)
libdbus-glib-1-doc - simple interprocess messaging system (GLib library documentation)
libdbusmenu-glib-dev - library for passing menus over DBus - development files
libdbusmenu-glib-doc - library for passing menus over DBus - documentation
libdbusmenu-glib4 - library for passing menus over DBus

python-avahi - Python utility package for Avahi

dnsutils - Clients provided with BIND

aspell-en - English dictionary for GNU Aspell
libgtkspell-dev - Development files for GtkSpell
libgtkspell0 - a spell-checking addon for GTK's TextView widget
libgtkspell3-3-0 - spell-checking addon for GTK+'s TextView widget
libgtkspell3-3-dev - Development files for GtkSpell
aspell-ru - Russian dictionary for Aspell
python-gtkspell - Python bindings for the GtkSpell library
python-gtkspellcheck - spellchecking library written in Python for Gtk based on Enchant
python-gtkspellcheck-doc - Python GTK Spellcheck common documentation
python3-gtkspellcheck - spellchecking library written in Python for Gtk based on Enchant

python-gnome2 - Python bindings for the GNOME desktop environment
python-gnome2-desktop-dev - Python bindings for the GNOME desktop environment
python-gnome2-dev - Python bindings for the GNOME desktop environment - development files
python-gnome2-doc - Python bindings for the GNOME desktop environment

python-gnome2 - Python bindings for the GNOME desktop environment
python-gnome2-desktop-dev - Python bindings for the GNOME desktop environment
python-gnome2-dev - Python bindings for the GNOME desktop environment - development files
python-gnome2-doc - Python bindings for the GNOME desktop environment
python-xdg - Python 2 library to access freedesktop.org standards
python3-xdg - Python 3 library to access freedesktop.org standards
python-gmenu - GNOME implementation of the freedesktop menu specification
python-gmenu-dbg - Python bindings for the freedesktop menu specification for GNOME (debug extension)

notification-daemon - daemon for displaying passive pop-up notifications
python-notify - Python bindings for libnotify

?
python-indicate - Python bindings for libindicate
python-notify2 - desktop notifications API for Python
python3-notify2 - desktop notifications API for Python 3
