#!/usr/bin/env ash
#
# Description : Cordless (Discord clone)
# Author      : Jose Cerrejon Gonzalez (ulysess@gmail_dot._com)
# Version     : 1.0 (May/20)
# Compatible  : Raspberry Pi 4
# Help		  : https://github.com/Bios-Marcel/cordless#installing-on-linux
#
clear
. ./helper.sh || wget -q 'https://raw.githubusercontent.com/jmcerrejon/alpinOS/master/scripts/helper.sh'
chmod +x helper.sh
. ./helper.sh


function install() {
	echo -e "This script compile Cordless (Discord clone).\nIt takes ~1 minute on a Raspberry Pi 4.\nWhen installed, type: cordless"
	apk add go build-base git
	cd ~
	git clone https://github.com/Bios-Marcel/cordless cordless && cd cordless
	go build .
	mv cordless /bin
	cd ..
	rm -rf go cordless
}

install

read -p "Do you want to save the app permanently (y/n)?: " option
case "$option" in
	y*) lbu add /bin && lbu commit -d ;;
	n*) return ;;
esac

read -p "Do you want to run Cordless right now (y/n)?: " option
case "$option" in
	y*) cordless ;;
	n*) return ;;
esac
