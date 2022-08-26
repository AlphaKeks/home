#!/bin/sh

killall picom
# picom -b --animations --animation-window-mass 0.3 --animation-for-open-window zoom --animation-stiffness 500 --experimental-backends --config $HOME/.config/picom/picom.conf &
picom -b --experimental-backends --config $HOME/.config/picom/picom.conf &

killall polybar
$HOME/.config/polybar/launch.sh &

killall dunst
dunst &

killall conky
conky -c $HOME/.config/conky/catppuccin.conf &

killall copyq
copyq &
