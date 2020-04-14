#!/usr/bin/env ash
#
# Description : DOSBox
# Author      : Jose Cerrejon Gonzalez (ulysess@gmail_dot._com)
# Version     : 1.0 (Apr/20)
# Compatible  : Raspberry Pi 4
#
clear
. ./helper.sh || wget -q 'https://raw.githubusercontent.com/jmcerrejon/alpinOS/master/scripts/helper.sh'
chmod +x helper.sh
. ./helper.sh


function install() {
	apk add dosbox
	## TODO Copy default .dosbox/dosbox-0.74-3.conf
}

function downloadGame() {
	local urlFile="https://misapuntesde.com/res/jill-of-the-jungle-the-complete-trilogy.zip"
	local installFullPath=~/games/dos/jill
	mkdir -p $installFullPath && cd $_
	wget -qO- -O tmp.zip $urlFile && unzip -o tmp.zip && rm tmp.zip
}

install
install_alsa
downloadGame