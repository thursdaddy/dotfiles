#!/usr/bin/env sh

killem () {
    killall -q polybar
    while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
}

get_monitors () {
    xrandr --query | grep -w "connected" | cut -f1 -d " " > /tmp/monlist
}

turn_off () (
    xrandr --query | grep -w "disconnected" | cut -f1 -d " " | grep -v eDP1
)

killem
get_monitors

if [[ $(wc -l < /tmp/monlist) -ge 3 ]]
then
    MULTI=1
else
    MULTI=0
fi

while read line
do
    MONITOR=$line
    if [[ $MONITOR = 'eDP1' ]]; then
        xrandr --output $MONITOR --auto
        MONITOR=$MONITOR polybar -q --reload main &
    fi
    if [[ $MONITOR = 'DP2' ]]; then
        if [ -z $1 ]; then
            xrandr --output $MONITOR --auto --left-of eDP1
            MONITOR=$MONITOR polybar -q --reload side &
        else
        xrandr --output $MONITOR --auto --$1-of eDP1
        MONITOR=$MONITOR polybar -q --reload side &
        fi
    fi
    if [[ $MONITOR = 'HDMI1' ]]; then
        if [ -z $1 ]; then
            if [[ $MULTI = '1' ]]; then
                echo $MULTI $MONITOR LEFT OF $(xrandr --query | grep -w "connected" | cut -f1 -d " " | sed '1d;$d')
                xrandr --output $MONITOR --auto --rotate left --left-of $(xrandr --query | grep -w "connected" | cut -f1 -d " " | sed '1d;$d')
                MONITOR=$MONITOR polybar -q --reload vert &
            elif [[ $MULTI = '0' ]]; then
                echo $MULTI $MONITOR LEFT OF $(xrandr --query | grep -w "connected" | cut -f1 -d " " | head -n1)
                xrandr --output $MONITOR --auto --left-of $(xrandr --query | grep -w "connected" | cut -f1 -d " " | head -n1)
                MONITOR=$MONITOR polybar -q --reload side &
            fi
        else
            if [[ $MULTI = '1' ]]; then
                echo $MULTI $MONITOR $1 OF $(xrandr --query | grep -w "connected" | cut -f1 -d " " | sed '1d;$d')
                xrandr --output $MONITOR --auto --rotate left --$1-of $(xrandr --query | grep -w "connected" | cut -f1 -d " " | sed '1d;$d')
                MONITOR=$MONITOR polybar -q --reload side &
            fi
        echo $MULTI $MONITOR $1 OF $(xrandr --query | grep -w "connected" | cut -f1 -d " " | head -n1)
        xrandr --output $MONITOR --auto --$1-of $(xrandr --query | grep -w "connected" | cut -f1 -d " " | head -n1)
        MONITOR=$MONITOR polybar -q --reload side &
        fi
    fi
    nitrogen --restore
done < /tmp/monlist

rm /tmp/monlist

DIS_MON=$(turn_off)
while IFS= read -r line
do
    MONITOR=$line
    if [[ $MONITOR = 'DP2' ]]; then
        xrandr --output $MONITOR --off
    elif [[ $MONITOR = 'HDMI1' ]]; then
        xrandr --output $MONITOR --off
    fi
done <<< $DIS_MON
