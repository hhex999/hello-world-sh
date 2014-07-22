#!/usr/bin/env sh

#*********************************************************************
# сборка gajim и python-nbxmpp из Mercurial репозитория
#*********************************************************************

# Установлен ли у нас mercurial -- он нам понадобится для
# скачивания исходного кода (не релиза, а dev ветки разработки) из
# Mercurial репозитория hg.gajim.org
sudo apt-get install mercurial

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
#sudo apt-get install intltool python-gtk2-dev python-xmpp python-pyxmpp

sudo apt-get remove  intltool python-gtk2-dev python-xmpp python-pyxmpp
sudo apt-get install intltool python-gtk2-dev
sudo apt-get autoremove

# Set certificate fingerprint: Add the folowing fingerprint for
# server hg.gajim.org into the ~/.hgrc Mercurial configuration file.

#[hostfingerprints]
#hg.gajim.org = 38:8d:67:e8:ce:76:7f:75:3d:ed:9b:b2:4a:06:aa:71:4c:14:fe:da

# исходя из комментария выше ^^^ взятого где-то на ... https://hg.gajim.org
# нам нужно занести "отпечаток сертификата" для сервера hg.gajim.org
# в ~/.hgrc конфигурационный файл Mercurial, делаем :

echo "[hostfingerprints]" >> ~/.hgrc
echo "hg.gajim.org = 38:8d:67:e8:ce:76:7f:75:3d:ed:9b:b2:4a:06:aa:71:4c:14:fe:da" >> ~/.hgrc

# если при попытке соединения с сервером команда `hg clone https://адрес`
# выдаст ошибку вроде этой :

# abort: certificate for hg.gajim.org has unexpected fingerprint
# 77:3b:82:49:eb:e0:92:b5:fd:46:af:fd:50:50:b7:9b:cd:55:9d:8a

# то тогда видимо сменился "отпечаток сертификата" сервера (у меня
# так и было, выдало ошибку) и нам нужно заменить строчку в конфиге
# ~/.hgrc с этой :
hg.gajim.org = 38:8d:67:e8:ce:76:7f:75:3d:ed:9b:b2:4a:06:aa:71:4c:14:fe:da
# на эту :
hg.gajim.org = 77:3b:82:49:eb:e0:92:b5:fd:46:af:fd:50:50:b7:9b:cd:55:9d:8a

# можно сделать этими командами :
# первая команда очистит целиком файл конфига ~/.hgrc
echo "" > ~/.hgrc

# остальные две команды занесут 2 строчки в пустой конфиг :
echo "[hostfingerprints]" >> ~/.hgrc
echo "hg.gajim.org = 77:3b:82:49:eb:e0:92:b5:fd:46:af:fd:50:50:b7:9b:cd:55:9d:8a" >> ~/.hgrc

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

# теперь можно собрать и установить python-nbxmpp
# переход в директорию
cd ~/build/python-nbxmpp
# читаем файл README внутри диретории python-nbxmpp (`q` для выхода из утилиты `less`)
less README
# исходя из README процедура установки будет следующей
# установка в систему
sudo python setup.py install

# а процедура удаления из системы (нужно читать доки по python distutils)
# думаю логично предположить что
cd ~/build/python-nbxmpp
sudo python setup.py uninstall

# про gajim из mercurial я пока не подготовил howto, да и там чуть
# разобраться надо бы, так что собирать будем из релизного gajim-0.16-rc2.tar.gz


#*********************************************************************
# отсюда начинается сбоhка gajim
# gajim-0.16-rc2.tar.gz
#*********************************************************************

# если повторю тут пару пакетов что были уже установлены ранее --
# ничего страшного, повторно они не установятся все равно.
# Это вроде как полный спикок зависимостей, как необходимых для сборки,
# так и дополнительные (для корректной работы некоторых функций gajim)

sudo apt-get install   python python2.7 python3 python-gtk2-dev intltool python-openssl python3-openssl python-pyasn1 python-pyasn1-modules python3-pyasn1 python-crypto python3-crypto libxss1 python-avahi dnsutils aspell-en aspell-ru libgtkspell0 libgtkspell3-3-0 python-gtkspell python-gtkspellcheck python3-gtkspellcheck python-gnome2 notification-daemon python-notify python-notify2 python3-notify2 dbus-x11 dbus libdbus-1-3 libdbus-glib-1-2 libdbusmenu-glib4

# поехали
# переход в директорию
cd ~/build

# распаковываем (TODO: если есть уже директория с этим именем и бинарник
# установлен в систему -- обычно есть файлы в /usr/local/bin, то не удалять
# директорию, сначала выполнить процедуру удаления пакета из системы и
# затем только удалять папку, иначе при распаковке -- команда ниже с
# ключами `-xf` просто перезапишет файлы при распаковке)
tar -xf gajim-0.16-rc2.tar.gz

# заходим в распакованную директорию
cd ~/build/gajim-0.16-rc2

# запуск скрипта конфигурирования
./configure --prefix=/usr/local

# запуск сборки пакета
make

# установка в систему и пересчет сист. файлов и библиотек
sudo make install
sudo ldconfig

# это процедура удаления из системы, нужно размаскировать при необходимости
#cd ~/build/gajim-0.16-rc2
#sudo make uninstall
#sudo ldconfig

# это для проверки, смотрим в директорию куда у нас было установлено,
# и если там пусто то удаляем папку с исходным кодом
#ls -l /usr/local/bin/
#cd ~/build
#rm -rf gajim-0.16-rc2

############################################################
 #1. tar jxvf gajim-version.tar.bz2
 #2. cd gajim
 #3. ./configure
 #4. make (builds translations)
 #5. su -c make install

#To specify where to install do:
    #./configure --prefix=custom_path
############################################################

# ? фиг знает, когда искал зависимости, то вот нашел, не уверен нужны
# ли эти пакеты
#libcrypto++-dev - General purpose cryptographic library - C++ development
#libcrypto++-doc - General purpose cryptographic library - documentation
#libcrypto++-utils - General purpose cryptographic library - utilities and data files
#libcrypto++9 - General purpose cryptographic library - shared library
#libcrypto++9-dbg - General purpose cryptographic library - debug symbols
#python-xdg - Python 2 library to access freedesktop.org standards
#python3-xdg - Python 3 library to access freedesktop.org standards
#python-gmenu - GNOME implementation of the freedesktop menu specification
#python-gmenu-dbg - Python bindings for the freedesktop menu specification for GNOME (debug extension)

# в конце хотел добавить, если что-то нужно сделать и не знаем где взять
# инфу, смотрим в архив с исходным кодом, там всегда почти есть папочка doc
# и файлы с заглавными именами вроде : README INSTALL AUTHORS LICENSE
# НЕ боимся их читать
# там в основном должна быть вся информация как собрать пакет и не только


############################################################
# НЕ РОБОТАТЬ (пока не нужно)
############################################################
# клонируем дерево исходного кода для gajim?
# переход в директорию сборки
cd ~/build
# клонируем gajim в альтернативную директорию gajim-mercurial (на всякий
# случай во избежание коллизий имен директорий)
hg clone https://hg.gajim.org/gajim gajim-mercurial

# итак, нам бы сделать архив-бэкап склонированного репозитория
tar -caf gajim-mercurial.tar.xz gajim-mercurial

cd ~/build/gajim-mercurial
less ChangeLog
# и видим такие строчки

#Gajim 0.16 ()
#
#  * Improve File transfer support by adding Jingle file transfer
#  * use external python-nbxmpp library

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
############################################################
# НЕ РОБОТАТЬ (пока не нужно)
############################################################
