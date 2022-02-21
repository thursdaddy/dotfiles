#!/usr/bin/bash

#$icon="$HOME/pictures/lock.png"
#$tmpbg='/tmp/screen.png'
#$
#$(( $# )) && { icon=$1; }
#$
#$scrot "$tmpbg"
#$convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
#$convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
#$i3lock -u -i "$tmpbg"

TMPBG=/tmp/screen.png
LOCK=$HOME/pictures/lock.png
#RES=5280x3040
RES=$(xrandr | grep 'current' | sed -E 's/.*current\s([0-9]+)\sx\s([0-9]+).*/\1x\2/')

if [ -z "$1" ]
    then
        ffmpeg -hide_banner -loglevel panic -f x11grab -video_size $RES -y -i $DISPLAY -i $LOCK -filter_complex "boxblur=16:1,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -vframes 1 $TMPBG
        i3lock -i $TMPBG
        sleep 10
        xset dpms force off
    else
        ffmpeg -hide_banner -loglevel panic -f x11grab -video_size $RES -y -i $DISPLAY -i $LOCK -filter_complex "boxblur=16:1,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -vframes 1 $TMPBG
        i3lock -i $TMPBG
        sleep 10
        xset dpms force off
fi
