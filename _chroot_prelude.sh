#!/bin/bash
if mount | grep '/opt/debian/tmp' > /dev/null; then
	echo "already in chroot!"
	exit 0
fi
mount -t proc proc /opt/debian/proc/
mount -t sysfs sys /opt/debian/sys/
mount -o bind /dev /opt/debian/dev/
mount -o bind /tmp /opt/debian/tmp/
