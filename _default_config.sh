#!/bin/bash
# You should not change the contents of this file after
# creating the chroot or strange things might happen.

# the ROS version to use
# e.g. kinetic or lunar
ROS_VERSION=kinetic
# the Debian version to use
# When set to "auto" the script will attempt to use the
# Debian version supported by the selected ROS version.
# e,g, auto, jessie, stretch
DEBIAN_VERSION=auto
# the root folder for the chroot
# e.g. /opt/debian, /home/user/chroot
CHROOT_ROOT=/opt/debian
# the username of the unprivileged user inside the chroot
# e.g. user, ros
CHROOT_USER=user
# uid of user inside chroot
# defaults to the uid of the user calling the script
# this is important to make sure the catkin workspace
# can be shared properly
# e.g. $SUDO_UID, 1000, 1001, ...
CHROOT_UID=$SUDO_UID
# gid of user inside chroot
# see CHROOT_UID
CHROOT_GID=$SUDO_GID
# the temporary folder to use
# If you use multiple parallel installations of ROSChroot,
# this should be different folders.
# e.g. /tmp/roschroot
TEMP_FOLDER=/tmp/roschroot
