#!/bin/zsh

# https://github.com/AlphaKeks

# Force interactive mode
[[ $- != *i* ]] && return

# PATH
export PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:$HOME/.bin:$HOME/.local/bin:$HOME/.bun/bin:$HOME/.cargo/bin

# History
HISTFILE=$ZDIR/history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory

# Options
setopt extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef
zle_highlight=('paste:none')
unsetopt BEEP

# Autocomplete
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[ -s "/home/alpha/.bun/_bun" ] && source "/home/alpha/.bun/_bun"

# Colors
autoload -Uz colors && colors

# Functions
source "$ZDIR/functions"
zsh_add_file "exports"
zsh_add_file "vim-mode"
zsh_add_file "aliases"
zsh_add_file "prompt"

zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

# Keybindings
bindkey -s '^g' 'lazygit^M'
bindkey '^[[P' delete-char

# Autostart
#neofetch
