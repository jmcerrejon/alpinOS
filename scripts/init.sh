#!/usr/bin/env ash
#
# Description : Init - Just some code to run when you start from scratch
# Author      : Jose Cerrejon Gonzalez (ulysess@gmail_dot._com)
# Version     : 1.0 (Apr/20)
# Compatible  : Raspberry Pi 4 (tested)
#
clear
wget -q 'https://raw.githubusercontent.com/jmcerrejon/alpinOS/master/scripts/helper.sh'
chmod +x helper.sh
. ./helper.sh

# Enable edge & community repositories
enable_repos

# My common packages when start from scratch
install_common_pkgs

# Clone my awesome repo
git clone https://github.com/jmcerrejon/alpinOS.git && cd alpinOS

# Copy some files for customize session
cp ./res/.profile ~/.profile && cp ./res/.bash_aliases ~/.bash_aliases

# Commit changes on /root
lbu add /root
lbu commit -d

# Add pi user
add_pi_user
