#!/bin/bash

WALLPAPER='/home/thurs/Pictures/wallpapers/blue-sky-mountain.jpg'
MONLIST=/tmp/monlist

get_connected_monitors () {
    xrandr -q | grep -w "connected" | cut -f1 -d" " > $MONLIST
    MONCOUNT=$(wc -l < $MONLIST)
    MAIN=$(sed -n '1p' < $MONLIST)
    SECOND=$(sed -n '2p' < $MONLIST)
    THIRD=$(sed -n '3p' < $MONLIST)
}

set_polybar () {
    killall -q polybar
    while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
    while read line
    do
        MONITOR=$line
        if [ $MONITOR = 'HDMI1' -a $MONCOUNT -eq 3 ]; then
            MONITOR=$MONITOR polybar -q --reload vert &
        elif [ MONITOR = 'HDMI1' ]; then
            MONITOR=$MONITOR polybar -q --reload side &
        elif [ $MONITOR = 'DP2' -o $MONITOR = 'DP1' ]; then
            MONITOR=$MONITOR polybar -q --reload side &
        elif [ $MONITOR = 'eDP1' ]; then
            MONITOR=$MONITOR polybar -q --reload main &
        fi
    done < $MONLIST
}

dock () {
    if [ $MONCOUNT = '3' ]; then
        xrandr --output $MAIN --auto --output $SECOND --auto --left-of $MAIN --output $THIRD --auto --left-of $SECOND --rotate left
    elif [ $MONCOUNT = '2' ]; then
        xrandr --output $MAIN --auto --output $SECOND --auto --left-of $MAIN 
    fi
    xrandr --output $MAIN --auto
    feh --bg-scale $WALLPAPER
}

disconnect_monitors () {
    DISCONNECTED=$(xrandr --query | grep -w "disconnected" | cut -f1 -d" ")
    while IFS= read -r line
    do
        MONITOR=$line
        if [ $MONITOR = 'HDMI1' ]; then
            xrandr --output $MONITOR --off
        elif [ $MONITOR = 'DP2' -o $MONITOR = 'DP1' ]; then
            xrandr --output $MONITOR --off
        fi
    done <<< $DISCONNECTED    
}

disconnect_monitors
get_connected_monitors
dock
set_polybar

rm /tmp/monlist
