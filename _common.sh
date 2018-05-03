#!/bin/bash

if [ -n "$DEBIAN_VERSION" ] ; then
    return
fi

[ -f _config.sh ] || cp _default_config.sh _config.sh
source _config.sh

if [ "$USE_SUID" != "0" ] ; then
    if [ "$SKIP_SUID_CHECK" != "1" -a ! \( -f "bin/automount" -a -f "bin/autoumount" -a -f "bin/autochroot" \) ] ; then
        echo "USE_SUID is set but some executables have not been compiled yet."
        echo "Set USE_SUID to 0 or run 0_setup_suid.sh!"
        exit 1
    fi
    if [ -z "$CHROOT_UID" ] ; then
        CHROOT_UID=`id -u`
    fi
    if [ -z "$CHROOT_GID" ] ; then
        CHROOT_GID=`id -g`
    fi
fi

if [ "$DEBIAN_VERSION" = "auto" ] ; then
    case "$ROS_VERSION" in
        "kinetic")
            DEBIAN_VERSION=jessie
            ;;
        "lunar")
            DEBIAN_VERSION=stretch
            ;;
        *)
            echo "Could not deduce debian version from ROS version. Please specify an exact debian version."
            exit 1
    esac
fi
