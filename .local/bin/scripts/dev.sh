#!/usr/bin/env bash

# choose project directory
PROJECT=$(find $HOME/Projects -mindepth 1 -maxdepth 2 -type d | fzf)

# go to project
cd "$PROJECT"

# get clean version of project name
PROJECT_NAME=$(echo "$PROJECT" | sed 's/.*Projects\/\(.*\)[.git]*\/.*/\1/')

# do tmux things
tmux new-session -s "$PROJECT_NAME" lazygit \
	\; rename-window "git" \
	\; new-window \
	\; rename-window "vim" \
	\; new-window \
	\; rename-window "fish" \
	\; new-window \
	\; rename-window "ssh" \
	\; select-window "-t:vim"

# vim:filetype=bash
