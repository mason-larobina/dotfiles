#!/bin/sh
source /etc/env.d/02locale
xset r rate 150 100
xrdb -all .Xresources
xmodmap .Xmodmap
xscreensaver &
exec awesome
