#!/bin/sh
xset fp rehash
xset r rate 150 100
xset +dpms
xset dpms 0 0 300
xrdb -all .Xresources
xmodmap .Xmodmap
exec ck-launch-session awesome
