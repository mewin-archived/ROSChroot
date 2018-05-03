if [ -n "$1" ] ; then
    cp "$1" "$CHROOT_ROOT/home/$CHROOT_USER/.Xauthority"
    chown "$CHROOT_UID:$CHROOT_GID" "$CHROOT_ROOT/home/$CHROOT_USER/.Xauthority"
fi
xhost +
