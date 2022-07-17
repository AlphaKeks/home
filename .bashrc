#!/bin/bash

# https://github.com/AlphaKeks

# Force interactive mode
[[ $- != *i* ]] && return

# PATH
export PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:$HOME/.bin:$HOME/.local/bin

# Exports
export EDITOR='nvim'
export TERM='alacritty'
export BROWSER='librewolf'

# QOL
bind "set completion-ignore-case on"
unpack ()
{
	if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Aliases
alias ls='ls --color=auto -lAH'
alias grep='grep --color=auto'
alias df='df -H'
alias mkdir='mkdir -p'
alias fucking='doas '

# Prompt
PS1='[\u@\h \W]\$ '

# Autostart
#neofetch
