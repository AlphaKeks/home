#!/usr/bin/env zsh

# https://github.com/AlphaKeks

# only run in interactive mode
[[ $- != *i* ]] && return

HISTFILE=$ZHIST
HISTSIZE=100000
SAVEHIST=100000

bindkey -v
# bindkey "^H" backward-kill-word
KEYTIMEOUT=1

eval "$(starship init zsh)"

source $HOME/.aliases

bindkey "^r" history-incremental-search-backward

source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
