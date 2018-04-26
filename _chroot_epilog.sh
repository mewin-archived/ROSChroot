#!/bin/bash

source _common.sh

rm -f /tmp/roschroot/pids/$$ >/dev/null 2>&1

for f in `ls -1 /tmp/roschroot/pids/` ; do
    if [ -d /proc/$f ] ; then
        echo "Someone is still using the chroot."
        exit 0
    fi
done

umount "$CHROOT_ROOT/tmp"
umount "$CHROOT_ROOT/dev"
umount "$CHROOT_ROOT/sys"
umount "$CHROOT_ROOT/proc"
