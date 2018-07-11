#!/bin/bash

MONITOR=$(xrandr --query | grep -w "connected" | awk '{print $1}' | grep -v eDP1)


dock () {
    xrandr --output $MONITOR --auto --left-of eDP1
    sleep 1
    $HOME/.config/polybar/launch.sh &
    notify-send -t 5000 "$MONITOR has been enabled!"
}

undock () {
    xrandr --output $MONITOR --off
    notify-send -t 5000 "$MONITOR has been disabled!"
}

case $1 in
  dock )
    dock ;;
  undock )
    undock ;;
esac

