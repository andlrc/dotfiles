# vim: fdm=marker

root_dir	= $$(git rev-parse --show-toplevel)

all:	wm shell editor config devel

.PHONY:	all wm i3 install-i3 irc irssi install-irssi shell zsh install-zsh    \
	editor vim install-vim ed install-ed config ctags install-ctags git X \
	termite install-termite fontconfig devel install-devel install-yaourt

# WM {{{

wm:	i3

i3:	install-i3
	mkdir -p ~/.config/i3
	-ln -s $(root_dir)/i3/i3.cfg ~/.config/i3/config
	-ln -s $(root_dir)/i3/i3status.cfg ~/.i3status.conf

install-i3: install-yaourt
	command -v i3        || sudo pacman -S i3-wm
	command -v i3lock    || sudo pacman -S i3lock
	command -v i3status  || sudo pacman -S i3status
	command -v xautolock || sudo pacman -S xautolock
	command -v amixer    || sudo pacman -S alsa-utils
	command -v dmenu     || sudo pacman -S dmenu
	command -v feh       || sudo pacman -S feh
	command -v redshift  || sudo pacman -S redshift
	command -v scrot     || sudo pacman -S scrot
	command -v xclip     || sudo pacman -S xclip
	command -v xdotool   || sudo pacman -S xdotool
	command -v unclutter || yaourt -S unclutter-xfixes-git
	test -e /usr/share/fonts/TTF/fontawesome-webfont.ttf || \
		yaourt -S ttf-font-awesome

# }}}
# IRC {{{

irc:	irssi

irssi:	install-irssi

install-irssi:
	command -v irssi || sudo pacman -S irssi

# }}}
# Shell {{{

shell:	zsh

zsh:	install-zsh
	-ln -s $(root_dir)/zsh/.zshrc ~/.zshrc
	-ln -s $(root_dir)/zsh/.zprofile ~/.zprofile

install-zsh:
	command -v zsh || sudo pacman -S zsh

# }}}
# Editor {{{

editor:	vim ed

vim:	install-vim ctags
	-ln -s $(root_dir)/vim ~/.vim

install-vim:
	command -v gvim || sudo pacman -S gvim

ed:	install-ed

install-ed:
	command -v ed || sudo pacman -S ed

# }}}
# Config {{{

config:	ctags git X termite fontconfig

ctags:	install-ctags
	-ln -s $(root_dir)/ctags/.ctags ~/.ctags

install-ctags: install-yaourt
	command -v ctags      || yaourt -S universal-ctags-git
	command -v rpglectags || yaourt -S rpglectags-git

git:
	-ln -s $(root_dir)/git/.gitconfig ~/.gitconfig

X:
	-ln -s $(root_dir)/X/.xinitrc ~/.xinitrc
	-ln -s $(root_dir)/X/.xinputrc ~/.xinputrc
	-ln -s $(root_dir)/X/.xmodmap ~/.xmodmap

termite: install-termite
	mkdir -p ~/.config/termite
	-ln -s $(root_dir)/termite/termite.cfg ~/.config/termite/config

install-termite:
	command -v termite || sudo pacman -S termite

fontconfig:
	mkdir -p ~/.config/fontconfig
	-ln -s $(root_dir)/fontconfig/fontconfig.xml ~/.config/fontconfig/config

# }}}
# Development {{{

devel:	install-devel editor shell config

install-devel: install-yaourt
	sudo pacman -S base-devel
	command -v firefox     || sudo pacman -S firefox
	command -v chromium    || sudo pacman -S chromium
	command -v node        || sudo pacman -S nodejs
	command -v npm         || sudo pacman -S npm
	command -v jq          || sudo pacman -S jq
	command -v wish        || sudo pacman -S tk
	command -v expect      || sudo pacman -S expect
	command -v dash        || sudo pacman -S dash
	command -v identify    || sudo pacman -S imagemagick
	command -v ssh         || sudo pacman -S openssh
	command -v openconnect || sudo pacman -S openconnect
	command -v pptp        || sudo pacman -S pptpclient
	command -v vpnc        || sudo pacman -S vpnc
	command -v gem         || sudo pacman -S ruby
	command -v cpan        || sudo pacman -S perl-cpan
	java -version 2>&1 | grep -q 'version.*1\.8' || \
		sudo pacman -S jre8-openjdk
	# Linters
	command -v jscs        || sudo npm install -g jscs
	command -v perlcritic  || sudo cpan install Perl::Critic
	command -v shellcheck  || sudo pacman -S shellcheck
	command -v scss-lint   || gem install scss_lint

YAOURT := $(shell command -v yaourt 2> /dev/null)
install-yaourt:
ifndef YAOURT
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
endif

# }}}
