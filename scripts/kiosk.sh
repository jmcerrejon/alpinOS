#!/usr/bin/env bash
#
# Description : Kiosk mode
# Author      : Jose Cerrejon Gonzalez (ulysess@gmail_dot._com)
# Version     : 1.0 (Apr/20)
# Compatible  : Raspberry Pi 4 (tested)
# Help  : https://wiki.alpinelinux.org/wiki/Xfce_Setup
# 		  https://troglobit.com/2017/09/10/install-x-window-in-alpine-linux/
#
clear
. ./helper.sh
check_board || { echo "Missing file helper.sh. I've tried to download it for you. Try to run the script again." && exit 1; }

function install() {
	echo 'Kiosk mode...'
	apk add chromium
	add_pi_user

}

install_X11
install