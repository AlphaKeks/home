#!/bin/sh

killall polybar

polybar main 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched."
