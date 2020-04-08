#!/usr/bin/env bash
#
# Description : XFCE
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
	echo 'Installing XFCE...'
	# TODO Check if package is already installed
	apk add xfce4 lxdm xfce4-terminal lightdm-gtk-greeter xfce4-screensaver dbus-x11 sudo tango-icon-theme
	rc-service dbus start
	# You will likely also want dbus to start on boot.
	# TODO ask user
	# rc-update add dbus

}

install_X11
install