#!/bin/bash
if [ `id -u` -ne 0 ] ; then
	sudo bash "$0" "$@"
	exit
fi

xhost +localhost
source _chroot_prelude.sh

# chroot /opt/debian sudo -u user /bin/bash
tmux -f tmux.conf

source _chroot_epilog.sh
