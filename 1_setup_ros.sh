#!/bin/bash
if [ `id -u` -ne 0 ] ; then
	sudo bash "$0" "$@"
	exit
fi

cat > /opt/debian/etc/apt/sources.list.d/ros-latest.list << 'EOF'
deb http://packages.ros.org/ros/ubuntu jessie main
EOF

cat > /tmp/setup_ros.sh << 'EOF'
#!/bin/bash
apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
apt update
yes | apt install ros-kinetic-desktop-full
rosdep init

sudo -u user bash /tmp/setup_ros_user.sh
EOF

cat > /tmp/setup_ros_user.sh << 'EOF'
#!/bin/bash
rosdep update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
EOF

source _chroot_prelude.sh

chroot /opt/debian /bin/bash --login /tmp/setup_ros.sh

source _chroot_epilog.sh
