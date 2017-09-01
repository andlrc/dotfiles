# vim: fdm=marker

P	= /usr/bin
DW	= $$(git rev-parse --show-toplevel)

all:	wm shell editor config devel

.PHONY:	all wm i3 irc irssi shell zsh editor vim ed config ctags git X \
	termite fontconfig devel

# WM {{{

wm:	i3

i3:	$P/i3 $P/i3lock $P/i3status $P/xautolock $P/amixer $P/dmenu $P/dmenu \
	$P/feh $P/redshift $P/scrot $P/xclip $P/xdotool $P/unclutter         \
	/usr/share/fonts/TTF/fontawesome-webfont.ttf
	mkdir -p ~/.config/i3
	-ln -s $(DW)/i3/i3.cfg ~/.config/i3/config
	-ln -s $(DW)/i3/i3status.cfg ~/.i3status.conf

$P/i3:
	sudo pacman -S i3-wm

$P/i3lock:
	sudo pacman -S i3lock

$P/i3status:
	sudo pacman -S i3status

$P/xautolock:
	sudo pacman -S xautolock

$P/amixer:
	sudo pacman -S alsa-utils

$P/dmenu:
	sudo pacman -S dmenu

$P/feh:
	sudo pacman -S feh

$P/redshift:
	sudo pacman -S redshift

$P/scrot:
	sudo pacman -S scrot

$P/xclip:
	sudo pacman -S xclip

$P/xdotool:
	sudo pacman -S xdotool

$P/unclutter: | $P/yaourt
	yaourt -S unclutter-xfixes-git

/usr/share/fonts/TTF/fontawesome-webfont.ttf: | $P/yaourt
	yaourt -S ttf-font-awesome

# }}}
# IRC {{{

irc:	irssi

irssi:	$P/irssi

$P/irssi:
	sudo pacman -S irssi

# }}}
# Shell {{{

shell:	zsh

zsh:	$P/zsh
	-ln -s $(DW)/zsh/.zshrc ~/.zshrc
	-ln -s $(DW)/zsh/.zprofile ~/.zprofile

$P/zsh:
	sudo pacman -S zsh

# }}}
# Editor {{{

editor:	vim ed

vim:	$P/gvim ctags
	test -e ~/.vim || ln -s $(DW)/vim ~/.vim

$P/gvim:
	sudo pacman -S gvim

ed:	$P/ed

$P/ed:
	sudo pacman -S ed

# }}}
# Config {{{

config:	ctags git X termite fontconfig

ctags:	$P/ctags $P/rpglectags
	-ln -s $(DW)/ctags/.ctags ~/.ctags

$P/ctags: | $P/yaourt
	yaourt -S universal-ctags-git

$P/rpglectags: | $P/yaourt
	yaourt -S rpglectags-git

git:
	-ln -s $(DW)/git/.gitconfig ~/.gitconfig

X:
	-ln -s $(DW)/X/.xinitrc ~/.xinitrc
	-ln -s $(DW)/X/.xinputrc ~/.xinputrc
	-ln -s $(DW)/X/.xmodmap ~/.xmodmap

termite: $P/termite
	mkdir -p ~/.config/termite
	-ln -s $(DW)/termite/termite.cfg ~/.config/termite/config

$P/termite:
	sudo pacman -S termite

fontconfig:
	mkdir -p ~/.config/fontconfig
	-ln -s $(DW)/fontconfig/fontconfig.xml ~/.config/fontconfig/config

# }}}
# Development {{{

devel:	editor shell config $P/firefox $P/chromium $P/node $P/npm $P/jq   \
	$P/wish $P/expect $P/dash $P/identify $P/ssh $P/openconnect       \
	$P/pptp $P/vpnc $P/core_perl/cpan $P/jscs $P/site_perl/perlcritic \
	$P/shellcheck

$P/firefox:
	sudo pacman -S firefox

$P/chromium:
	sudo pacman -S chromium

$P/node:
	sudo pacman -S nodejs

$P/java:
	sudo pacman -S jre8-openjdk

$P/jq:
	sudo pacman -S jq

$P/wish:
	sudo pacman -S tk

$P/expect:
	sudo pacman -S expect

$P/dash:
	sudo pacman -S dash

$P/identify:
	sudo pacman -S imagemagick

# Connections
$P/ssh:
	sudo pacman -S openssh

$P/openconnect:
	sudo pacman -S openconnect

$P/pptp:
	sudo pacman -S pptpclient

$P/vpnc:
	sudo pacman -S vpnc

# Package Managers
$P/npm: | $P/node
	echo $P/npm
	sudo pacman -S npm

$P/core_perl/cpan:
	sudo pacman -S perl-cpan

# Linters
$P/jscs: | $P/npm
	sudo npm install -g jscs

$P/site_perl/perlcritic: | $P/core_perl/cpan
	sudo cpan install Perl::Critic

$P/shellcheck:
	sudo pacman -S shellcheck

$P/yaourt:
	mkdir -p build
	# Package Query
	test -d build/pq || \
		git clone https://aur.archlinux.org/package-query.git \
		build/pq
	cd build/pq && makepkg -si \
	# Yaourt
	test -d build/yu || \
		git clone https://aur.archlinux.org/yaourt.git \
		build/yu
	cd build/yu && mkpkg -si

# }}}
