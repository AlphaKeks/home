#!/bin/sh

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:$HOME/.local/bin:$HOME/.local/bin/scripts:$HOME/.cargo/bin:$HOME/.local/share/nvim/mason/bin

# export TERM="xterm-256color"
export TERM="screen-256color"
export EDITOR="nvim"
export BROWSER="firefox"

export ZHIST=$HOME/.zhist

export XCURSOR_SIZE=24
export _JAVA_AWT_WM_NONREPARENTING=1

export EXA_COLORS="ur=34:uw=34:ux=34:gr=34:gw=34:gx=34:tr=34:tw=34:tx=34:uu=35:gu=35"
export FZF_DEFAULT_OPTS="--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

xrdb -merge $HOME/.Xresources

export RUST_BACKTRACE=full
export CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse

export PATH="/run/user/1000/fnm_multishells/25152_1683311877350/bin":$PATH
export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
export FNM_VERSION_FILE_STRATEGY="local"
export FNM_ARCH="x64"
export FNM_DIR="/home/alphakeks/.local/share/fnm"
export FNM_LOGLEVEL="info"
export FNM_MULTISHELL_PATH="/run/user/1000/fnm_multishells/25152_1683311877350"
