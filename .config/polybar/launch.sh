#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

HDMI_CHECK=$(xrandr --query | grep -w "HDMI.* connected" | cut -d" " -f1)
if [[ $HDMI_CHECK == HDMI* ]]; then
	MONITOR=eDP1 polybar --reload side & 
	MONITOR=$HDMI_CHECK polybar --reload main & 
else
	MONITOR=eDP1 polybar main &
fi

DP_CHECK=$(xrandr --query | grep -w "DP.* connected" | cut -d" " -f1)
if [[ $DP_CHECK == DP* ]]; then
	MONITOR=$DP_CHECK polybar --reload side &
fi
