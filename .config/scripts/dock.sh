#!/bin/bash

MONITOR=$(xrandr --query | grep -w "connected" | awk '{print $1}' | grep -v eDP1)


dock () {
  xrandr --output $MONITOR --auto --left-of eDP1
  sleep 1
  $HOME/.config/polybar/launch.sh &
}

function undock {
	xrandr --output $MONITOR --off
}

case $1 in
  dock )
	dock ;;
  undock )
	undock ;;
esac

