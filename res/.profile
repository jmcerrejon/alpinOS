export DISPLAY=:0
export PATH=/usr/lib/:$PATH

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

function edit_config() {
	mount -o remount,rw /media/mmcblk0p1
	nano /media/mmcblk0p1/config.txt
}

function edit_userconfig() {
	mount -o remount,rw /media/mmcblk0p1
	nano /media/mmcblk0p1/userconfig.txt
}