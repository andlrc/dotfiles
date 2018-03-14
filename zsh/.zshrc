# vim: fdm=marker

# Basic Settings {{{1

CDPATH="$HOME/work"

setopt auto_pushd pushd_ignore_dups pushdminus

# Make <C-w> follow vim more closely
WORDCHARS='@'

# History configuration {{{1

setopt HIST_IGNORE_SPACE
HISTSIZE=1000000000
HISTFILESIZE=1000000000
SAVEHIST=1000000000
HISTFILE="$HOME/.zsh_history"

# Convenience mappings {{{1

bindkey -e

# <C-Z> will call 'fg' when no process is running in the foreground {{{2

toggle-ctrl-z () {
	if [ "${#BUFFER}" -eq 0 ]
	then
		if [ "$(jobs | wc -l)" -gt 0 ]
		then
			fg
			zle accept-line
		fi
	else
		zle push-input
	fi
}
zle -N toggle-ctrl-z
bindkey '^Z' toggle-ctrl-z

# <C-X><C-E> will edit current command in editor {{{2

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# Pre command and PS1, PS2, right PS1 {{{1

precmd()
{
	if find ~/mail/new -mindepth 1 | read
	then
		printf "You have mail.\n"
	fi
}

declare -x PROMPT="$ "
declare -x PROMPT2="> "

# More POSIX {{{1

setopt NO_NOMATCH
setopt RM_STAR_SILENT

# Command completion {{{1

# Enable <tab> completion
autoload -U compinit promptinit
compinit

# Compilation
unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end

# <C-I>
bindkey '^I' expand-or-complete-prefix

# <C-N>, <C-p>
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search

# <S-Tab>
bindkey '^[[Z' reverse-menu-complete

# Highlight currently selection suggestion
zstyle ':completion:*:*:*:*:*' menu select

# Aliases {{{1

# Suppress annoying directory print when directory is found in '$CDPATH'
alias cd="cd > /dev/null"

alias l='ls -lAh'

alias grep="grep --color=auto --exclude-dir=.git"

# Function and includes {{{1

work()
{
	CDPATH="$CDPATH${CDPATH:+:}/mnt/dksrv206/www/dev"
}

u()
{
	PATH="$PATH"
}

d()
{
	date +'Week %W, %a %F, %T'
}
