#!/bin/bash

source _common.sh

if [ "$USE_SUID" == "0" -a `id -u` -ne 0 ] ; then
	sudo bash "$0" "$HOME/.Xauthority"
	exit
elif [ -z "$1" ] ; then
    bash "$0" "$HOME/.Xauthority"
    exit
fi

source _enable_x.sh

source _chroot_prelude.sh

if [ "$USE_SUID" != "0" ] ; then
    bin/autochroot bash
else
    chroot "$CHROOT_ROOT" sudo -u $CHROOT_USER /bin/bash
fi

source _chroot_epilogue.sh
