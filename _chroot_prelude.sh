#!/bin/bash

trap "source '$(pwd)/_chroot_epilogue.sh'" INT

PID_FILE="$TEMP_FOLDER/pids/$$"

mkdir -p `dirname "$PID_FILE"`
touch "$PID_FILE"

if [ `id -u` -eq 0 ] ; then
    chown -R "$SUDO_UID:$SUDO_GID" "$TEMP_FOLDER"
fi

if mount | grep "$CHROOT_ROOT/tmp" > /dev/null; then
	echo "chroot already mounted!"
elif [ "$USE_SUID" != "0" ] ; then
    bin/automount
else
    mount -t proc proc "$CHROOT_ROOT/proc"
    mount -t sysfs sys "$CHROOT_ROOT/sys"
    mount -o bind /dev "$CHROOT_ROOT/dev"
#    mount -o bind /dev/pts "$CHROOT_ROOT/dev/pts"
    mount -o bind /tmp "$CHROOT_ROOT/tmp"
fi
