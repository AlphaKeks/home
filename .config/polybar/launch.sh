#!/bin/sh

killall polybar

polybar left 2>&1 | tee -a /tmp/polybar.log & disown
polybar middle 2>&1 | tee -a /tmp/polybar.log & disown
polybar right 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched."
