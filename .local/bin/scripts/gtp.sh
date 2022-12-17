#!/usr/bin/env zsh

SELECTED=$(find ~/Projects -mindepth 1 -maxdepth 1 -type d | fzf)

cd $SELECTED &&
	clear &&
	echo $fg[green] "➡ $SELECTED" $fg[white] &&
	la

