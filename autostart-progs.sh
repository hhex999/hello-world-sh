#!/usr/bin/env sh

# setxkbmap -layout us,ru -option grp:alt_shift_toggle,grp_led:scroll
setxkbmap -layout "us,ru" -option "grp:alt_shift_toggle" -option "terminate:ctrl_alt_bksp" &
#####
# FEH BACKGROUND SETTING
# feh can also be used as a background setter.  Unless you pass the
# --no-fehbg option, it will store the command line necessary to set
# the background in ~/.fehbg, so to have your background restored
# every time you start X, you can add "eval $(cat ~/.fehbg)" to your X
# startup script (like ~/.xinitrc).
# --bg-center
# --bg-fill
# --bg-max
# --bg-scale
# --bg-tile
# feh --image-bg black --bg-max '~/222wall/Statue_of_Lao_Tzu_in_Quanzhou.jpg' &
# to your X startup script (like ~/.xinitrc).
eval $(cat ~/.fehbg) &
#####
# tint2 &
# sleep 6
# xterm -e top &
# kteatime &
# ktimetracker &
kwalletmanager &
kmix &
# kontact &
# gpg-agent --daemon &
# mpd &
# ~/projects/shell_bash/autostart-progs.sh &
# ~/conky-autostart.sh &
# parcellite &

