#!/bin/sh

source ~/.zshenv
xrandr --output DisplayPort-0 --mode 1920x1080 --rate 240.30 --primary --dpi 96
xrandr --output DisplayPort-1 --mode 1920x1080 --rate 60.00 --left-of DisplayPort-0 --dpi 96
xrandr --output DisplayPort-2 --mode 1920x1080 --rate 60.00 --above DisplayPort-0 --dpi 96
xrandr --output HDMI-A-0 --mode 1920x1080 --rate 60.00 --right-of DisplayPort-0 --dpi 96
xmodmap -e "pointer = 1 2 3"
xrdb ~/.Xresources

exec bspwm
