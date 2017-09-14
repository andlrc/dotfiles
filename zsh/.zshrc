# vim: fdm=marker
# Author Andreas Louv <andreas@louv.dk>
# This is my personal zsh configuration.
# Use at own risk, NO WARRANTY, to the extent permitted by law.
# Basic Settings {{{1

export CDPATH="$HOME/work"

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
  if [ "${#BUFFER}" -eq 0 ]; then
    if [ "$(jobs | wc -l)" -gt 0 ]; then
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

precmd () {
  # List most recent changed files when changing directory
  if [ ! "$_OLDDIR" = "$PWD" ]; then
    ls --color=always -lAht | sed '1d;7q'
  fi

  _OLDDIR="$PWD"

  # Set terminal title to current directory
  print -Pn "\e]2;%d\a"
}

declare -x PROMPT="%~ "
declare -x PROMPT2="--> "

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

# Make <Tab> complete word left of cursor instead word under cursor:
# sud|ls /etc/blah -> <Tab> -> sudols /etc/blah
#    ^ Cursor
bindkey '^I' expand-or-complete-prefix

# Write part of command and press <C-P>/<C-N> complete it though history search
# and bring the cursor to the end of the line
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search

# Enable <S-Tab> to reverse navigation though suggestions
bindkey '^[[Z' reverse-menu-complete

# Color coding suggested directories, files, executable, ...
zstyle ':completion:*' list-colors ''

# Highlight currently selection suggestion
zstyle ':completion:*:*:*:*:*' menu select

# Enable case-insensitive completing
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Complete for vpnc
compdef '_files -W /etc/vpnc' vpnc

# Complete for zipSeries
compdef _gnu_generic zipSeries

# Aliases {{{1

# Suppress annoying directory print when directory is found in '$CDPATH'
alias cd="cd > /dev/null"

alias ls='ls --color=auto'
alias l='ls -lAh'

alias grep="grep --color=auto --exclude-dir=.git"

# Function and includes {{{1

work() {
  export CDPATH="$CDPATH${CDPATH:+:}/mnt/dksrv206/www/dev"
}

u() {
  export PATH="$PATH"
}

d() {
  date +'Week %W, %a %F, %T'
}

export SITEMULE_CTAGS=1

if [ -f "$HOME/work/Sitemule/util/.zshrc" ]; then
  source "$HOME/work/Sitemule/util/.zshrc"
fi

if [ -f "$HOME/work/extensions/util/.zshrc" ]; then
  source "$HOME/work/extensions/util/.zshrc"
fi

# }}}
