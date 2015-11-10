# /usr/bin/VBoxClient-all

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

setxkbmap -model pc104 -layout us,ru -option grp:shifts_toggle

pkill -f redshift
redshift &

pkill -f stalonetray
stalonetray &

pkill -f xscreensaver
xscreensaver -no-splash &

pkill -f batterymon
batterymon &

exec xmonad
