#!/bin/bash
# You should not change the contents of this file after
# after creating the chroot or strange things might happen.

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
