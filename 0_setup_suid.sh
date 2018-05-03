#!/bin/bash

SKIP_SUID_CHECK=1
source _common.sh

if [ `id -u` -ne 0 ] ; then
    sudo  bash "$0" "$@"
    exit
fi

echo "#define CHROOT_ROOT \"$CHROOT_ROOT\"" > c_sources/chroot_config.h
echo "#define CHROOT_USER \"$CHROOT_USER\"" >> c_sources/chroot_config.h
echo "#define MOUNT \"$(which mount)\"" >> c_sources/chroot_config.h
echo "#define UMOUNT \"$(which umount)\"" >> c_sources/chroot_config.h
echo "#define CHROOT \"$(which chroot)\"" >> c_sources/chroot_config.h
echo "#define TMUX \"$(which tmux)\"" >> c_sources/chroot_config.h
echo "#define TMUX_CONF \"$(pwd)/tmux.conf\"" >> c_sources/chroot_config.h

echo "Content of c_sources/chroot_config.h:"
echo "---"
cat c_sources/chroot_config.h
echo "---"

echo "Please make sure everything is set correctly!"

mkdir -p bin

gcc -O2 -o bin/automount c_sources/automount.c
chmod +s bin/automount

gcc -O2 -o bin/autoumount c_sources/autoumount.c
chmod +s bin/autoumount

gcc -O2 -o bin/autochroot c_sources/autochroot.c
chmod +s bin/autochroot

gcc -O2 -o bin/autotmux c_sources/autotmux.c
chmod +s bin/autotmux
