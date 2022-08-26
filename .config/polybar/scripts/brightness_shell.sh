#!/bin/sh

brightness_level=$(brightnessctl g)
brightness_max=$(brightnessctl m)

brightness_percent=$(( $brightness_level * 100 / $brightness_max ))

if [ "$brightness_percent" -gt 85 ]; then
    echo "%{u#ffe898 +u} $brightness_percent%"
elif [ "$brightness_percent" -gt 50 ]; then
    echo "%{u#FF6E00 +u} $brightness_percent%"
elif [ "$brightness_percent" -lt 49 ]; then
    echo "%{u#FF6E00 +u} $brightness_percent%"
elif [ "$brightness_percent" -lt 10 ]; then
    echo "%{u#FF6E00 +u} $brightness_percent%"
fi

