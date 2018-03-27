if test -d /etc/X11/xinit/xinitrc.d; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    test -x "$f" && . "$f"
  done
  unset f
fi

# When running 'startx' the current directory is inherited by the X-session and
# therefore each opened terminal emulator will start in said directory.
cd ~

# A naive way to disable the TouchPad
id=$(xinput list |
     sed -n '/TouchPad\|Synaptics TM3075-002/ {
     		s/.*=\([[:digit:]]*\).*/\1/p
		q
	     }')
test -n "$id" && xinput disable "$id"

xrdb ~/.Xresources
xmodmap ~/.xmodmap

exec ssh-agent i3 > /tmp/i3-log 2>&1
