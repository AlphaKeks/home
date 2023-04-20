#!/usr/bin/env zsh

source $HOME/.zshenv
setxkbmap alpha

# for X11
# [ "$(tty)" = "/dev/tty1" ] && startx

# for Wayland
# [ "$(tty)" = "/dev/tty1" ] && exec dbus-launch --sh-syntax --exit-with-session Hyprland
