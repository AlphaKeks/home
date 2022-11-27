#!/usr/bin/zsh

# https://github.com/AlphaKeks

# always run in interactive mode
[[ $- != *i* ]] && return

# history settings
HISTFILE=$ZDIR/history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory

# some options
setopt extendedglob nomatch menucomplete interactive_comments
stty stop undef
zle_highlight=("paste:none")
unsetopt BEEP

# colors
autoload -Uz colors && colors

# autocomplete
autoload -Uz compinit
zstyle ":completion:*" menu select
zmodload zsh/complist
_comp_options+=(globdots)
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# vim mode
bindkey -v
export KEYTIMEOUT=1

function zle-keymap-select() {
	case $KEYMAP in
		vicmd) echo -ne "\e[2 q";; # block
		viins|main) echo -ne "\e[6 q";; # beam
	esac
}

zle -N zle-keymap-select

# always use beam on startup
precmd() {
	echo -ne "\e[6 q"
}

# plugins
function add_file() {
	[ -f "$ZDIR/$1" ] && source "$ZDIR/$1"
}

function add_plugin() {
	NAME=$(echo $1 | cut -d "/" -f 2)
	if [ -d "$ZDIR/plugins/$NAME" ]; then
		add_file "plugins/$NAME/$NAME.plugin.zsh" || \
		add_file "plugins/$NAME/$NAME/zsh"
	else
		git clone "https://github.com/$1.git" "$ZDIR/plugins/$NAME"
	fi
}

add_plugin "zsh-users/zsh-autosuggestions"
add_plugin "zsh-users/zsh-syntax-highlighting"

# prompt
autoload -Uz vcs_info
zstyle ":vcs_info:*" enable git

precmd_vcs_info() {
	vcs_info
}

precmd_functions+=( precmd_vcs_info )

setopt prompt_subst
zstyle ":vcs_info:git*+set-message:*" hooks git-untracked

+vi-git-untracked() {
	if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == "true" ]] && \
		git status --porcelain | grep "??" &> /dev/null ; then
		hook_com[stages]+="!"
	fi
}

zstyle ":vcs_info:*" check-for-changes true
zstyle ":vcs_info:git:*" formats "%r/%S %b %m%u%c"
zstyle ":vcs_info:git:*" formats "%F{#cdd6f4}(%F{#f38ba8}%m%u%c%F{#f9e2af}%F{#cba6f7} %b%F{#cdd6f4}) "

PROMPT=" %F{#cdd6f4}➡ %F{#7480c2}%1d "
PROMPT+="\$vcs_info_msg_0_"
PROMPT+="%F{#cdd6f4}"

# aliases
alias \
	ls="/bin/ls --color=auto -hl" \
	la="ls -A" \
	mkdir="mkdir -p" \
	grep="grep --color=auto" \
	clear="tput reset" \
	cls="clear && neofetch" \
	cya="loginctl poweroff now" \
	reboot="loginctl reboot" \
	fucking="doas" \
	remove-orphans="fucking pacman -R \$(pacman -Qtdq)" \
	rm="rm -I" \
	..="cd .." \
	.1="cd .." \
	.2="cd ../.." \
	.3="cd ../../.." \
	.4="cd ../../../.." \
	.5="cd ../../../../.." \
	df="cd ~/.dotfiles" \
	vim="/usr/bin/nvim" \
	nvim="/usr/bin/nvim --clean" \
	lg="lazygit" \
	make="make -j24" \
	rain="cmatrix -u 10 -C blue -o -m" \
	dl3="yt-dlp -x --audio-format mp3" \
	dl4="yt-dlp -f mp4" \
	ssh:schnose="ssh max@schnose" \
	pack="tar -czvf" \
	da="ncdu" 

# count lines recursively
lc() { find $1 -type f | xargs wc -l | sort }

# extract numbers from file and sort and add them
sac() { sort -t "," -k2 -n $1 | awk -F"," '{s+=$2} END {print s}' }

# airplay for ipad
airplay() {
	doas avahi-daemon &
	uxplay
}

unpack() {
	if [ -f $1 ]; then
		case $1 in
			*.tar.bz2)   tar xjf $1                      ;;
			*.tar.gz)    tar xzf $1                      ;;
			*.bz2)       bunzip2 $1                      ;;
			*.rar)       unrar x $1                      ;;
			*.gz)        gunzip $1                       ;;
			*.tar)       tar xf $1                       ;;
			*.tbz2)      tar xjf $1                      ;;
			*.tgz)       tar xzf $1                      ;;
			*.zip)       unzip $1                        ;;
			*.Z)         uncompress $1                   ;;
			*.7z)        7z x $1                         ;;
			*.deb)       ar x $1                         ;;
			*.tar.xz)    tar xf $1                       ;;
			*.tar.zst)   tar xf $1                       ;;
			*)           echo "'$1' cannot be extracted.";;
		esac
	else
		echo "\"$1\" is not a valid archive."
	fi
}
