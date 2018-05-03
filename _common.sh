#!/bin/bash

if [ -n "$DEBIAN_VERSION" ] ; then
    return
fi

if [ ! -f _config.sh ] ; then
    echo "Config not found. Please copy _default_config.sh to _config.sh and customize it before using the scripts."
    exit 1
fi
source _config.sh

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
