#!/bin/sh

export DOTFILES=$HOME/.dotfiles
export CFG=$HOME/.config
export ZDIR=$CFG/zsh
source $HOME/.zshenv

[ "$(tty)" = "/dev/tty1" ] && startx
# [ "$(tty)" = "/dev/tty1" ] && exec dbus-launch --sh-syntax --exit-with-session <some wayland window manager>
