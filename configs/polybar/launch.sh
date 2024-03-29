#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar top >>/tmp/polybar3.log 2>&1 &
sleep 2
polybar vright >>/tmp/polybar1.log 2>&1 &
polybar main >>/tmp/polybar2.log 2>&1 &

echo "Bars launched..."
