#!/bin/bash

source _common.sh

if [ `id -u` -ne 0 ] ; then
	sudo bash "$0" "$@"
	exit
fi

sed s/DEBIAN_VERSION/$DEBIAN_VERSION/g > "$CHROOT_ROOT/etc/apt/sources.list.d/ros-latest.list" << 'EOF'
deb http://packages.ros.org/ros/ubuntu DEBIAN_VERSION main
EOF

sed "s/ROS_VERSION/$ROS_VERSION/g; s/CHROOT_USER/$CHROOT_USER/g" > /tmp/setup_ros.sh << 'EOF'
#!/bin/bash
apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
apt update
yes | apt install ros-ROS_VERSION-desktop-full
rosdep init

sudo -u CHROOT_USER bash /tmp/setup_ros_user.sh
EOF

sed s/ROS_VERSION/$ROS_VERSION/g > /tmp/setup_ros_user.sh << 'EOF'
#!/bin/bash
rosdep update
echo "source /opt/ros/ROS_VERSION/setup.bash" >> ~/.bashrc
EOF

source _chroot_prelude.sh

chroot "$CHROOT_ROOT" /bin/bash --login /tmp/setup_ros.sh

source _chroot_epilogue.sh
