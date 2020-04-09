#!/usr/bin/env bash
#
# Description : RetroArch
# Author      : Jose Cerrejon Gonzalez (ulysess@gmail_dot._com)
# Version     : 1.0 (Apr/20)
# Compatible  : Raspberry Pi 4 (tested)
#
clear
. ./helper.sh || wget -q 'https://raw.githubusercontent.com/jmcerrejon/alpinOS/master/scripts/helper.sh'
check_board || { echo "Missing file helper.sh. I've tried to download it for you. Try to run the script again." && exit 1; }

function install() {
	echo 'Installing Retroarch...'
	# TODO Check if package is already installed
	apk add --upgrade retroarch
}

install_X11
install