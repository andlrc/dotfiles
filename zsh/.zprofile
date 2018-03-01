# vim: fdm=marker
# Author Andreas Louv <andreas@louv.dk>

# Environment Variables {{{1

export DW_ROOT="$HOME/work/dw"

# Default Editor
export VISUAL=ed
export EDITOR="$VISUAL"

export LC_ALL=en_US.UTF-8
export LANG="$LC_ALL"
export LANGUAGE="$LC_ALL"

export NODE_PATH="/usr/lib/node_modules"

# The PATH list need to be set before startx is called, this will make
# 'i3' and therefore 'dmenu_run' run with the proper path
path+=(
	"/usr/share/perl6/vendor/bin"
	"$HOME/bin"
	"$DW_ROOT/bin"
	"$HOME/.gem/ruby/2.4.0/bin"
)
