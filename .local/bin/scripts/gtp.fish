#!/usr/bin/env fish

set SELECTED (find ~/Projects -mindepth 1 -maxdepth 1 -type d | fzf)

cd $SELECTED &&
	clear &&
	set_color green &&
	echo "➡ $SELECTED"
	set_color normal &&
	exa -al --icons

# vim:filetype=fish
