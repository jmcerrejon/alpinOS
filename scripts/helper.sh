#!/usr/bin/env bash
# Great resource: https://wiki.alpinelinux.org/wiki/Raspberry_Pi

#
# Check what is your SBC
#
function check_board() {
	if [[ $(cat /proc/cpuinfo | grep 'ODROIDC') ]]; then
		MODEL="ODROID-C1"
	elif [[ $(cat /proc/cpuinfo | grep 'BCM2708\|BCM2709\|BCM2835') ]]; then
		MODEL="Raspberry Pi"
	elif [ "$(uname -n)" = "debian" ]; then
		MODEL="Debian"
	elif [[ $(grep orangepizero /etc/armbian-release) ]]; then
		MODEL="Orange Pi Zero"
	else
		MODEL="UNKNOWN"
		dialog --title '[ WARNING! ]' --msgbox "Board or Operating System not compatible.\nUse at your own risk." 6 45
	fi
}

#
# Enable edge repo. Note: enable the repository for community if you want vim,
# mc, php, apache, nginx, etc.
#
function enable_edge() {
	sed -i '/edge/s/^#//' etc/apk/repositories
}

#
# Fix clock
#
function fix_clock() {
	rc-update del hwclock boot
	rc-update add swclock boot
	service hwclock stop
	service swclock start
	echo 'NOTE: type busybox'
	setup-ntp
	commit_changes
}

#
# Connect WiFi devices
# Help: https://wiki.alpinelinux.org/wiki/Connecting_to_a_wireless_access_point
#
function add_wifi() {
	apk add wireless-tools wpa_supplicant
	ip link set wlan0 up
	# TODO Make a cool menu for ask the next steps
	iwlist wlan0 scanning | grep 'ESSID'
	iwconfig wlan0 essid TDC_032E # TDC_032E is an example
	iwconfig wlan0
	read -p "Type the password: " input
	wpa_passphrase 'TDC_032E' "${input}" > /etc/wpa_supplicant/wpa_supplicant.conf
	wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf
	udhcpc -i wlan0
	ip addr show wlan0
	auto wlan0
	iface wlan0 inet dhcp
	rc-update add wpa_supplicant boot
	commit_changes
	# /etc/init.d/wpa_supplicant start # To start it manually
}

#
# Add the Pi user
#
function add_pi_user() {
	adduser -g 'John Wick' pi
	# Remove user with deluser pi
}

#
# Essentials X11 libs
#
function install_X11() {
	setup-xorg-base
	apk add xmodmap mesa-dri-vc4 mesa-egl xf86-video-fbdev xf86-video-vesa xf86-input-mouse xf86-input-keyboard dbus setxkbmap kbd xrandr xset xinit xterm
}

#
# Add sound to our World
#
function install_alsa() {
	apk add alsa-base alsa-utils
	# usermod -a -G audio ${USER}
}

#
# Dumb function, I know it
#
function sshfs() {
	apk add sshfs
	modprobe fuse
	mkdir -p /home/pi/remote/
	# Example of use: sshfs ulysess@192.168.0.104:/Users/ulysess/Documents/sc/alpinOS/scripts/ /home/pi/remote/
}

function commit_changes() {
	lbu commit -d
}