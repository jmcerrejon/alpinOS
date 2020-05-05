#!/usr/bin/env sh
#
# Description : PostgreSQL
# Author      : Jose Cerrejon Gonzalez (ulysess@gmail_dot._com)
# Version     : 1.0 (Apr/20)
# Compatible  : Raspberry Pi 4
#
clear
. ./helper.sh || wget -q 'https://raw.githubusercontent.com/jmcerrejon/alpinOS/master/scripts/helper.sh'
chmod +x helper.sh
. ./helper.sh


install() {
	apk add postgresql postgresql-client
	/etc/init.d/postgresql setup
	/etc/init.d/postgresql start && rc-update add postgresql default
}

install