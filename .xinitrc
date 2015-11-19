# /usr/bin/VBoxClient-all

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

setxkbmap -model pc104 -layout us,ru -option grp:shifts_toggle

redshift &
stalonetray &
xscreensaver -no-splash &
batterymon &
nm-applet    2>&1 /dev/null &
syndaemon -k -i 0.4 &

export `gnome-keyring-daemon -d`

exec xmonad

pkill redshift
pkill stalonetray
pkill -f xscreensaver
pkill -f batterymon
pkill nm-applet
pkill syndaemon
