#!/bin/bash

killall -q picom

sleep 1

picom --config $HOME/.config/picom/picom.conf -b &
