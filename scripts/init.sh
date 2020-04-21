#!/usr/bin/env sh
#
# Description : Init - Just some code to run when you start from scratch
# Author      : Jose Cerrejon Gonzalez (ulysess@gmail_dot._com)
# Version     : 1.5 (Apr/20)
# Compatible  : Raspberry Pi 4 (tested)
#
clear
[ ! -f ./helper.sh ] && wget -q 'https://raw.githubusercontent.com/jmcerrejon/alpinOS/master/scripts/helper.sh'
chmod +x helper.sh
. ./helper.sh
[ -d "./res" ] && resource=./res || resource=../res

# Enable edge & community repositories
enable_repos

# My common packages when start from scratch
install_common_pkgs

# We don't need too many tty consoles
remove_ttys

# Clone my awesome repo
if [ ! -d ~/alpinOS ]; then
	git clone https://github.com/jmcerrejon/alpinOS.git && cd alpinOS
fi

# Copy some files for customize session
cp $resource/.profile ~/.profile && cp $resource/.bash_aliases ~/.bash_aliases

# Commit changes on /root
lbu add /root
lbu commit -d

# Add pi user
if ! id -u pi > /dev/null 2>&1; then
	add_pi_user
fi

read -p "Do you want to reboot? [y/n] " yn
case $yn in
	[Yy]* ) reboot;;
	[Nn]* ) ;;
	* ) "Invalid input. Exiting...";;
esac