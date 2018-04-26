#!/bin/bash
if [ `id -u` -ne 0 ] ; then
	sudo bash "$0" "$HOME/.Xauthority"
	exit
fi

if [ -n "$1" ] ; then
    cp "$1" "/opt/debian/home/user/.Xauthority"
fi

xhost +
source _chroot_prelude.sh

chroot /opt/debian sudo -u user /bin/bash

source _chroot_epilog.sh
