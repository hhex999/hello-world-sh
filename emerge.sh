#!/usr/bin/env sh

# TODO : make parse `date` == grep\sed\awk

#sleep 600
#DATE=$(date +%D)
#SNAPSHOT="http://mirror.switch.ch/ftp/mirror/gentoo/snapshots/portage-$(echo $DATE)"
#portage-20140509.tar.xz
#portage-20140509.tar.xz.gpgsig
#portage-20140509.tar.xz.md5sum
#portage-20140509.tar.xz.umd5sum
######################################################################

SNAPSHOT_LOCAL_DIR="~/ftp/pub/gentoo/snapshots/"
SNAPSHOT="http://mirror.switch.ch/ftp/mirror/gentoo/snapshots/portage-"
DATE="20140719"
FTPD="~/projects/shell_bash/vsftpd.sh"

cd $SNAPSHOT_LOCAL_DIR

###



echo "=== fetching portage snapshot files" && sleep 5
function fetching_snapshot_files {
cd $SNAPSHOT_LOCAL_DIR
we_are_here=`pwd`
echo -e "=== current dir = $we_are_here"
for i in \
"${SNAPSHOT}${DATE}.tar.xz" \
"${SNAPSHOT}${DATE}.tar.xz.gpgsig" \
"${SNAPSHOT}${DATE}.tar.xz.md5sum" \
"${SNAPSHOT}${DATE}.tar.xz.umd5sum"
do
wget -c "$i"
done
}

call_fetching_snapshot_files=$(fetching_snapshot_files || echo "=== fetching failed")



###



echo "=== chownning files" && sleep 5
function chown_files {
for i in $SNAPSHOT_LOCAL_DIR/*
do
chown -R ftp:ftp "$i"
done
}

call_chown_files=$(chown_files || echo "=== chowning failed")



###



echo "=== restarting FTP daemon" && sleep 5
function ftpd_restart {
killall vsftpd
exec ~/projects/shell_bash/vsftpd.sh
}

call_ftpd_restart=$(ftpd_restart || echo "=== ftpd restarting failed")



###



echo "=== do EMERGE SYNC" && sleep 5
function emerge_syncing {
emerge-webrsync -v
}

call_emerge_syncing=$(emerge_syncing || echo "=== emerge syncing failed")



###



echo "=== do LAYMAN SYNC" && sleep 5
function layman_syncing {
layman -S
}

call_layman_syncing=$(layman_syncing || echo "=== layman syncing failed")



###



#eix-update -v
echo "=== do EIX index UPDATE" && sleep 5
function eix_updating {
eix-update
}

call_eix_updating=$(eix_updating || echo "=== eix index updating failed")



###



echo "=== do Q index UPDATE" && sleep 5
function q_updating {
q -r
}

call_q_updating=$(q_updating || echo "=== q updating failed")



###

echo -e $call_fetching_snapshot_files
echo "=== fetching done"

echo -e $call_chown_files
echo "=== chowning done"

echo -e $call_ftpd_restart
echo "=== ftpd restarting done"

echo -e $call_emerge_syncing
echo "=== emerge syncing done"

echo -e $call_layman_syncing
echo "=== layman syncing done"

echo -e $call_eix_updating
echo "=== eix index updating done"

echo -e $call_q_updating
echo "=== q updating done"





echo "*" && echo "* you can now check for the " && \
echo "= sudo emerge -avfuDN --keep-going=y --with-bdeps=y @world ="
#sudo emerge -avfuDN --keep-going=y --with-bdeps=y @world
#sudo emerge -avuDN --keep-going=y --with-bdeps=y @world
#sudo emerge -av @preserved-rebuild
#sudo emerge -av @module-rebuild
######################################################################
# --ask --columns --complete-graph --deep --fetchonly --fetch-all-uri
# --keep-going --newuse --oneshot --pretend --tree --update --verbose
# --with-bdeps=y
# --complete-graph --with-bdeps=y
# emerge --pretend --verbose --update --deep --newuse --keep-going=y @world
# emerge -pvuDN --keep-going=y @world
# emerge --pretend --verbose --update --deep --newuse --keep-going=y --with-bdeps=y @world
# emerge -pvuDN --keep-going=y --with-bdeps=y @world
# emerge -pve @world
# emerge -pvc
# emerge -aC
######################################################################
