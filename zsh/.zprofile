# vim: fdm=marker
# Author Andreas Louv <andreas@louv.dk>
# This is my personal zsh configuration.
# Use at own risk, NO WARRANTY, to the extent permitted by law.
# Environment Variables {{{1

export DW_ROOT="$HOME/work/dw"

# i3-terminal, needs to be at the top before startx is called, otherwide the
#   terminal will not explicit be set to termite
declare -x TERMINAL=termite

# Default Editor
declare -x VISUAL=vim
declare -x EDITOR="$VISUAL"

declare -x LC_ALL=en_US.UTF-8
declare -x LANG="$LC_ALL"
declare -x LANGUAGE="$LC_ALL"

declare -x NODE_PATH="/usr/lib/node_modules"

# The PATH list need to be set before startx is called, this will make
# 'i3' and therefore 'dmenu_run' run with the proper path
path+=(
  "/usr/share/perl6/vendor/bin"
  "$HOME/bin"
  "$HOME/work/zipSeries/bin"
  "$HOME/work/charinfo"
  "$DW_ROOT/bin"
  "$HOME/.gem/ruby/2.4.0/bin"
)
export PATH
