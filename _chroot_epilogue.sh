#!/bin/bash

source _common.sh

rm -f "$TEMP_FOLDER/pids/$$" >/dev/null 2>&1

for f in `ls -1 "$TEMP_FOLDER/pids/"` ; do
    if [ -d /proc/$f ] ; then
        echo "Someone is still using the chroot."
        exit 0
    fi
done

umount -l "$CHROOT_ROOT/tmp"
# umount -l "$CHROOT_ROOT/dev/pts"
umount -l "$CHROOT_ROOT/dev"
umount -l "$CHROOT_ROOT/sys"
umount -l "$CHROOT_ROOT/proc"
