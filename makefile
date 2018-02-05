# vim: fdm=marker

P	= /usr/bin
DW	= $(shell git rev-parse --show-toplevel)

all:	wm shell editor config devel

clean:
	-rm -r ~/.config/i3/config
	-rmdir ~/.config/i3
	-rm -r ~/.i3status.conf
	-rm -r ~/.zshrc
	-rm -r ~/.zprofile
	-rm -r ~/.vim
	-rm -r ~/.ctags
	-rm -r ~/.gitconfig
	-rm -r ~/.xinitrc
	-rm -r ~/.inputrc
	-rm -r ~/.xmodmap
	-rm -r ~/.config/termite/config
	-rmdir ~/.config/termite
	-rm -r ~/.config/fontconfig/config
	-rmdir ~/.config/fontconfig
	-rm ~/.mailcap

.PHONY:	all clean wm i3 irc irssi shell zsh editor vim ed config	\
	ctags git X termite fontconfig mail devel

# WM {{{

wm:	i3

i3:	$P/i3 $P/i3lock $P/i3status $P/xautolock $P/amixer $P/dmenu	\
	$P/dmenu $P/feh $P/redshift $P/scrot $P/xclip $P/xdotool 	\
	$P/unclutter /usr/share/fonts/TTF/fontawesome-webfont.ttf	\
	~/.config/i3/config ~/.i3status.conf

~/.config/i3/config:	$(DW)/i3/i3.cfg
	mkdir -p ~/.config/i3
	ln -s $(DW)/i3/i3.cfg ~/.config/i3/config

~/.i3status.conf:	$(DW)/i3/i3status.cfg
	ln -s $(DW)/i3/i3status.cfg ~/.i3status.conf

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

$P/unclutter:|	$P/yaourt
	yaourt -S unclutter-xfixes-git

/usr/share/fonts/TTF/fontawesome-webfont.ttf:|	$P/yaourt
	yaourt -S ttf-font-awesome-4

# IRC {{{1

irc:	irssi

irssi:	$P/irssi

$P/irssi:
	sudo pacman -S irssi

# Shell {{{1

shell:	zsh

zsh:	$P/zsh ~/.zshrc ~/.zprofile

~/.zshrc:	$(DW)/zsh/.zshrc
	ln -s $(DW)/zsh/.zshrc ~/.zshrc

~/.zprofile:	$(DW)/zsh/.zprofile
	ln -s $(DW)/zsh/.zprofile ~/.zprofile

$P/zsh:
	sudo pacman -S zsh

# Editor {{{1

editor:	vim ed

vim:	~/.vim $P/gvim ctags

~/.vim:	$(DW)/vim
	ln -s $(DW)/vim ~/.vim

$P/gvim:
	sudo pacman -S gvim

ed:	$P/ed

$P/ed:
	sudo pacman -S ed

# Config {{{1

config:	ctags git X readline termite fontconfig mail

ctags:	$P/ctags $P/rpglectags ~/.ctags

~/.ctags:	$(DW)/ctags/.ctags
	ln -s $(DW)/ctags/.ctags ~/.ctags

$P/ctags:|	$P/yaourt
	yaourt -S universal-ctags-git

$P/rpglectags:|	$P/yaourt
	yaourt -S rpglectags-git

git:	~/.gitconfig

~/.gitconfig:	$(DW)/git/.gitconfig
	ln -s $(DW)/git/.gitconfig ~/.gitconfig

X:	~/.xinitrc ~/.xmodmap

~/.xinitrc:	$(DW)/X/.xinitrc
	ln -s $(DW)/X/.xinitrc ~/.xinitrc

~/.xmodmap:	$(DW)/X/.xmodmap
	ln -s $(DW)/X/.xmodmap ~/.xmodmap

readline: ~/.inputrc

~/.inputrc:	$(DW)/readline/.inputrc
	ln -s $(DW)/readline/.inputrc ~/.inputrc

termite:	$P/termite ~/.config/termite/config

~/.config/termite/config:	$(DW)/termite/termite.cfg
	mkdir -p ~/.config/termite
	ln -s $(DW)/termite/termite.cfg ~/.config/termite/config

$P/termite:
	sudo pacman -S termite

fontconfig:	~/.config/fontconfig/config

~/.config/fontconfig/config:	$(DW)/fontconfig/fontconfig.xml
	mkdir -p ~/.config/fontconfig
	ln -s $(DW)/fontconfig/fontconfig.xml ~/.config/fontconfig/config

mail:	$P/mutt $P/w3m $P/urlview ~/.mailcap ~/.mutt/muttrc

~/.mailcap:	$(DW)/mail/mailcap
	ln -s $(DW)/mail/mailcap ~/.mailcap

~/.mutt/muttrc:
	mkdir -p ~/.mutt
	ln -s $(DW)/mail/muttrc ~/.mutt/muttrc

$P/mutt:
	sudo pacman -S mutt

$P/w3m:
	sudo pacman -S w3m

$P/urlview:|	$P/yaourt
	yaourt -S urlview

# Development {{{1

devel:	editor shell config $P/firefox $P/chromium $P/node $P/npm $P/jq	\
	$P/wish $P/expect $P/dash $P/identify $P/zs			\
	$P/ssh $P/openconnect $P/pptp $P/vpnc $P/core_perl/cpan		\
	$P/jscs $P/site_perl/perlcritic $P/shellcheck $P/pylint		\
	$P/errno $P/dig $P/kill $P/pip

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

$P/zs:|	$P/yaourt
	yaourt -S zs-git

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
$P/npm:|	$P/node
	echo $P/npm
	sudo pacman -S npm

$P/core_perl/cpan:
	sudo pacman -S perl-cpan

# Linters
$P/jscs:|	$P/npm
	sudo npm install -g jscs

$P/site_perl/perlcritic:|	$P/core_perl/cpan
	sudo cpan install Perl::Critic

$P/shellcheck:
	sudo pacman -S shellcheck

$P/pylint:
	sudo pacman -S python-pylint

$P/errno:
	sudo pacman -S moreutils

$P/dig:
	sudo pacman -S bind-tools

$P/kill:
	sudo pacman -S util-linux

$P/pip:
	sudo pacman -S python-pip

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
