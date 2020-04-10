#!/usr/bin/env bash
# Great resource: https://wiki.alpinelinux.org/wiki/Raspberry_Pi
# OTHERS		: https://postmarketos.org/

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
# Enable edge repo and community. Note: enable the repository for community if you want vim,
# mc, php, apache, nginx, etc.
#
function enable_repos() {
	sed -i '/community/s/^#//' /etc/apk/repositories
	sed -i '/edge/s/^#//' /etc/apk/repositories
	apk update
	while true; do
      read -p "Do you want to upgrade the OS? [y/n] " yn
      case $yn in
        [Yy]* ) apk upgrade; break ;;
        [Nn]* ) exit 1 ;;
        * ) echo "Please answer (y)es or (n)o.";;
      esac
    done
	commit_changes
}

#
# My common packages when start from scratch
#
function install_common_pkgs() {
	# https://misapuntesde.com/post.php?id=916 <- netatalk
	# https://misapuntesde.com/post.php?id=438 <- sshfs
	apk add -U git nano mc rng-tools raspberrypi htop xrandr sshfs netatalk
	commit_changes
}

#
# kill all processes from user
#
function kill_user() {
	ps -e -o user,pid | grep '"{$1}"' | awk '{ print $2 }' | xargs kill
}

#
# Set bash as default shell
#
function set_bash() {
	apk add bash bash-completion
	sed -i 's/ash/bash/g' /etc/passwd
	cp ../res/.bashrc ~/.bashrc
	cp ../res/.bash_aliases ~/.bash_aliases
	commit_changes
}

#
# Add the Pi user
# NOTE: Remove it with: deluser pi
#
function add_pi_user() {
	adduser -g 'John Wick' pi
	chown -R pi /home/pi
	lbu add /home/pi
	while true; do
      read -p "Do you want to boot with user pi automatically? [y/n] " yn
      case $yn in
        [Yy]* ) sed -i 's/tty1::respawn:\/sbin\/getty 38400 tty1/tty1::respawn:\/bin\/login -f pi/g' /etc/inittab; break ;;
        [Nn]* ) exit 1 ;;
        * ) echo "Please answer (y)es or (n)o.";;
      esac
    done
	commit_changes
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
	read -p "Type your SSID: " ssid
	iwconfig wlan0 essid "${ssid}"
	iwconfig wlan0
	read -p "Type the password: " input
	wpa_passphrase "${ssid}" "${input}" > /etc/wpa_supplicant/wpa_supplicant.conf
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
	apk add alsa-base alsa-utils alsa-lib alsaconf
	rc-service alsa start
	rc-update add alsa
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

#
# Expand with the full disk size
# FIXME It doesn't work. HELP ME!
#
function expand_disk() {
	blkid # get info about partitions
	apk add cfdisk
	umount -a
	cfdisk /dev/mmcblk0
}

function vbox() {
	apk add -U virtualbox-guest-additions virtualbox-guest-modules-virt
	modprobe -a vboxsf
	mount -t vboxsf vbox_shared /mnt/outside
}

function commit_changes() {
	lbu commit -d
}