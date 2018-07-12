#!/bin/bash

## script will check for attached monitor and dock if found
## currently only supports 1 monitor and is
## posistioned left of laptop screen

MONITOR=$(xrandr --query | grep -w "connected" | awk '{print $1}' | grep -v eDP1 | head)

dock () {
    xrandr --output ${MONITOR} --auto --left-of eDP1
    sleep 1
    $HOME/.config/polybar/launch.sh &
    notify-send -t 5000 "${MONITOR} has been enabled!"
}

undock () {
    if [ -z ${MONITOR} ]; then
      for mon in DP1 HDMI1; do 
          notify-send -t 5000 "Disabling output: $mon"
          xrandr --output $mon --off
      done
    else
    notify-send -t 5000 "Disabling output: ${MONITOR}"
    xrandr --output ${MONITOR} --off
    fi
}

case $1 in
  dock )
    dock ;;
  undock )
    undock ;;
esac

## check for argument, if none:
## dock if monitor attached
## undock if no monitor attached

if [ -z "$1" ]; then
    if [ -z "${MONITOR}" ]; then
        undock
    else
        dock
    fi
fi

