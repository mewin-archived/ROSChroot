#!/bin/bash

rm -f /tmp/roschroot/pids/$$ >/dev/null 2>&1

for f in `ls -1 /tmp/roschroot/pids/` ; do
    if [ -d /proc/$f ] ; then
        echo "Someone is still using the chroot."
        exit 0
    fi
done

umount /opt/debian/tmp
umount /opt/debian/dev
umount /opt/debian/sys
umount /opt/debian/proc
