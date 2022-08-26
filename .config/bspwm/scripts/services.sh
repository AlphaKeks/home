#!/bin/sh

killall xfce-polkit
/usr/lib/xfce-polkit/xfce-polkit &

killall xfce4-power-manager
/bin/xfce4-power-manager &

killall easyeffects
/usr/bin/easyeffects --gapplication-service &
