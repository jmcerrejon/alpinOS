#!/usr/bin/env ash
#
# Description : Init - Just some code to run when you start from scratch
# Author      : Jose Cerrejon Gonzalez (ulysess@gmail_dot._com)
# Version     : 1.0 (Apr/20)
# Compatible  : Raspberry Pi 4 (tested)
#
clear
wget -q 'https://raw.githubusercontent.com/jmcerrejon/alpinOS/master/scripts/helper.sh'
. ./helper.sh

# Enable edge & community repositories
enable_repos

# My common packages when start from scratch
install_common_pkgs

add_pi_user

git clone https://github.com/jmcerrejon/alpinOS.git

echo -e '\nSystem is ready!...Have a nice day.\n'