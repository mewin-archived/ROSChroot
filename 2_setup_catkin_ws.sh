#!/bin/bash

source _common.sh

if [ `id -u` -ne 0 ] ; then
	sudo bash "$0" "$@"
	exit
fi

if [ -e "$HOST_CATKIN_WS_PATH" ] ; then
    echo "$HOST_CATKIN_WS_PATH already exists. Aborting."
    exit 1
fi

sed s/ROS_VERSION/$ROS_VERSION/g > /tmp/setup_catkin.sh << 'EOF'
#!/bin/bash
source /opt/ros/ROS_VERSION/setup.bash
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws
catkin_make
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
EOF

source _chroot_prelude.sh

chroot "$CHROOT_ROOT" sudo -u "$CHROOT_USER" /bin/bash --login /tmp/setup_catkin.sh

source _chroot_epilogue.sh

echo "Linking $HOST_CATKIN_WS_PATH to catkin workspace."
mkdir -p "`dirname "$HOST_CATKIN_WS_PATH"`"
ln -s "$CHROOT_ROOT/home/$CHROOT_USER/catkin_ws" "$HOST_CATKIN_WS_PATH"
