#!/bin/bash

trap "source '$(pwd)/_chroot_epilog.sh'" INT

mkdir -p /tmp/roschroot/pids
touch /tmp/roschroot/pids/$$

if mount | grep "$CHROOT_ROOT/tmp" > /dev/null; then
	echo "chroot already mounted!"
else
    mount -t proc proc "$CHROOT_ROOT/proc"
    mount -t sysfs sys "$CHROOT_ROOT/sys"
    mount -o bind /dev "$CHROOT_ROOT/dev"
    mount -o bind /tmp "$CHROOT_ROOT/tmp"
fi
