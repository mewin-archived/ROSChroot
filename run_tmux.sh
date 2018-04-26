#!/bin/bash

source _common.sh

if [ `id -u` -ne 0 ] ; then
	sudo bash "$0" "$HOME/.Xauthority"
	exit
fi

if [ -n "$1" ] ; then
    cp "$1" "$CHROOT_ROOT/home/$CHROOT_USER/.Xauthority"
fi

xhost +
source _chroot_prelude.sh

echo "set-option -g default-command \"chroot $CHROOT_ROOT sudo -u $CHROOT_USER /bin/bash\"" > tmux.conf
tmux -f tmux.conf

source _chroot_epilog.sh
