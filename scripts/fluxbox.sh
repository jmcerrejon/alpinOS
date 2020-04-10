#!/usr/bin/env ash
#
# Description : Fluxbox
# Author      : Jose Cerrejon Gonzalez (ulysess@gmail_dot._com)
# Version     : 1.0 (Apr/20)
# Compatible  : Raspberry Pi 4 (tested)
# Help  : https://ubuntuforums.org/showthread.php?t=1201273
#		  http://www.linuxfromscratch.org/blfs/view/svn/x/fluxbox.html
#
clear
. ./helper.sh || wget -q 'https://raw.githubusercontent.com/jmcerrejon/alpinOS/master/scripts/helper.sh'
check_board || { echo "Missing file helper.sh. I've tried to download it for you. Try to run the script again." && exit 1; }

function install() {
	echo 'Installing Fluxbox...'
	# TODO Check if package is already installed
	apk add fluxbox
	# startfluxbox should be started from your ~/.xinitrc if you use startx,
    # or ~/.xsession if you run a display manager, like xdm.
	echo 'exec startfluxbox' > ~/.xinitrc
	fluxbox-generate_menu
}

install_X11
install