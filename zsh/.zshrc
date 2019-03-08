setopt NO_NOMATCH
setopt RM_STAR_SILENT

# cd
setopt AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHDMINUS
CDPATH="$HOME/work"

# history
setopt HIST_IGNORE_SPACE
HISTSIZE=1000000000
HISTFILESIZE=1000000000
SAVEHIST=1000000000
HISTFILE="$HOME/.zsh_history"

# prompt
bindkey -e
WORDCHARS=@
PROMPT="%~ $ "
PROMPT2="> "

# completion
autoload -U compinit
compinit
unsetopt AUTO_MENU

# mappings
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search

alias l='ls -lAh'
alias grep="grep --color=auto --exclude-dir=.git"
alias ed='rlwrap -S: ed'

precmd() {
	if ! test "$silent_mail_info"
	then
		cnt=$(find ~/mail/new -mindepth 1 | wc -l | tr -d '[:space:]')
		if test "$cnt" -gt 0
		then
			echo "You have new mail ($cnt)."
		fi
	fi
}

# Silence mail info
s() {
	if test "$silent_mail_info"
	then
		unset silent_mail_info
	else
		silent_mail_info=Y
	fi
}

work() {
	CDPATH="$CDPATH${CDPATH:+:}/mnt/dksrv206/www/dev"
	export SYSTEM='work-build ""'
	export SYSTEM_UP='work-build "$?"'
}

u() {
	PATH="$PATH"
}

dc() {
	if test "$#" -eq 0
	then
		echo "running dc with 10 as precision:"
		echo "$ rlwrap dc -e10k /dev/stdin"
		command rlwrap dc -e10k /dev/stdin
	else
		command dc "$@"
	fi
}

d() {
	date +'Week %W, %a %F, %T'
}
