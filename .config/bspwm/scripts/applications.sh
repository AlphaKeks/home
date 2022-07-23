#!/bin/sh

killall screencloud
screencloud &

killall signal-desktop
signal-desktop &

killall thunderbird
thunderbird &

killall discord
discord &

killall unclutter
unclutter &

killall steam
steam -silent &

killall discover-overlay
discover-overlay &
