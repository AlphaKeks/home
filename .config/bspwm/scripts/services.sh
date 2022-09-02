#!/bin/sh

killall pipewire
/usr/bin/pipewire &

killall xfce-polkit
/usr/lib/xfce-polkit/xfce-polkit &

killall xfce4-power-manager
/bin/xfce4-power-manager &

killall easyeffects
/usr/bin/easyeffects --gapplication-service &

killall otd
/bin/otd &
