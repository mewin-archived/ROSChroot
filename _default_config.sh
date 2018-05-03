#!/bin/bash
# You should not change the contents of this file after
# creating the chroot or strange things might happen.

if [ `id -u` -eq 0 -a -z "$SUDO_USER" ] ; then
    echo "Please invoke these scripts as normal user."
    exit 1
fi

# load default config for anything not set here
if [ -z "$_DEFAULT_SOURCED" ] ; then
    _DEFAULT_SOURCED=1
    source _default_config.sh
fi

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
# path for catkin workspace on host
# default to ~/catkin_ws
# e.g. /home/bob/Documents/Catkin
HOST_CATKIN_WS_PATH="`eval echo ~$SUDO_USER`/catkin_ws"
# the temporary folder to use
# If you use multiple parallel installations of ROSChroot,
# this should be different folders.
# e.g. /tmp/roschroot
TEMP_FOLDER=/tmp/roschroot
# use suid executables
# this will prevent the sudo prompt from showing
# to use this you first have to compile the suid executables
# using 0_setup_suid.sh
# e.g. 0, 1
USE_SUID=0
