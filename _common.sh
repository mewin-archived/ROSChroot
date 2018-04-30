#!/bin/bash

if [ -n "$DEBIAN_VERSION" ] ; then
    return
fi

[ -f _config.sh ] || cp _default_config.sh _config.sh
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
