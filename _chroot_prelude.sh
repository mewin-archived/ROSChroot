#!/bin/bash

trap "source '$(pwd)/_chroot_epilog.sh'" INT

mkdir -p /tmp/roschroot/pids
touch /tmp/roschroot/pids/$$

if mount | grep '/opt/debian/tmp' > /dev/null; then
	echo "chroot already mounted!"
else
    mount -t proc proc /opt/debian/proc/
    mount -t sysfs sys /opt/debian/sys/
    mount -o bind /dev /opt/debian/dev/
    mount -o bind /tmp /opt/debian/tmp/
fi
