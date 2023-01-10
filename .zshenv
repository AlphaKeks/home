#!/usr/bin/env zsh

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/.local/bin:$HOME/.local/bin/scripts:$HOME/.cargo/bin:$HOME/.local/share/nvim/mason/bin

export EDITOR="nvim"

export TERM="xterm-256color"

export TERMINAL="wezterm"

export BROWSER="firefox"

export FZF_DEFAULT_OPTS="--color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD"

export EXA_COLORS="ur=34:uw=34:ux=34:gr=34:gw=34:gx=34:tr=34:tw=34:tx=34:uu=35:gu=35"

export _JAVA_AWT_WM_NONREPARENTING=1

export XCURSOR_SIZE=24

xrdb -merge $HOME/.Xresources

source $HOME/.openai
