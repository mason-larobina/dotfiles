#!/bin/sh
xset r rate 150 100
xrdb -all .Xresources
xmodmap .Xmodmap
xscreensaver &
exec awesome
