#!/bin/sh

speed=$(sensors | grep fan1 | cut -d " " -f 9)

if [ "$speed" != "" ]; then
    speed_round=$(echo "scale=0;$speed/1" | bc -l )
    echo "$speed_round"
else
   echo "off"
fi
