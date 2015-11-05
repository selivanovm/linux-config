/usr/bin/VBoxClient-all

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

setxkbmap -model pc104 -layout us,ru -option grp:shifts_toggle

exec xmonad
