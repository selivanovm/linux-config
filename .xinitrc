# /usr/bin/VBoxClient-all

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

#eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
#export SSH_AUTH_SOCK

setxkbmap -model pc104 -layout us,ru -option grp:shifts_toggle

if [ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi

redshift &
stalonetray &
xscreensaver -no-splash &
batterymon &
nm-applet    2>&1 /dev/null &
syndaemon -k -i 1 &
dropbox &

export `gnome-keyring-daemon -d`

exec xmonad

pkill redshift
pkill stalonetray
pkill -f xscreensaver
pkill -f batterymon
pkill nm-applet
pkill syndaemon
pkill dropbox
