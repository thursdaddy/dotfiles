#!/bin/bash
xscreensaver &
xbindkeys
/usr/bin/syndaemon -K -i 0.5 -R &
systemctl --user set-environment DISPLAY=:0
wal -R 
xrdb -load ~/.Xresources
exec i3
