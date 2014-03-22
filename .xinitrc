#!/bin/sh
xset fp rehash
xset r rate 250 50
xscreensaver -no-splash &
xset +dpms
xset dpms 0 0 300
xrdb -merge .Xresources
xmodmap .Xmodmap
exec ck-launch-session awesome
