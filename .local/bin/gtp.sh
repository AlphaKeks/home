#!/bin/sh

selected=$(find ~/projects -mindepth 1 -maxdepth 1 -type d | fzf)

cd $selected &&
	clear &&
	echo $fg[green] "➡ $selected" $fg[white] &&
	ls
