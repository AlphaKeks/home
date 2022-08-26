#!/bin/bash

BAR_HEIGHT=35  # polybar height
BORDER_SIZE=0  # border size from your wm settings
YAD_WIDTH=222  # 222 is minimum possible value
YAD_HEIGHT=193 # 193 is minimum possible value
DATE="$(date +"%a %d %Y ~ %H:%M")"

rofi -modi window -show window -show-icons -sidebar-mode
