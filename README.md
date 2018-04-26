Some scripts to setup a debian chroot and to install [ROS](http://www.ros.org) (the robot operating system) inside of it.
This is just a personal mirror for myself and anyone who is interested. I do not plan to support it. So issues and pull requested will probably be ignored.

# Prerequisites
Before executing the scripts make sure the following tools are installed:
- curl (for downloading debootstrap)
- wget (required by debootstrap)
- chroot (obviously)
- ar/tar for extracting debootstrap
- tmux (used for terminal multiplexing when entering chroot)
- xhost (required for X connection inside chroot)
- sudo (to execute the scripts as root)

# Usage
**Be warned: this scripts may contain serious bugs that may break your system. I am not responsible for any harm that is done.**
1. Edit _config.sh and make sure it fits your needs.
1. Create the chroot by executing `bash 0_create_chroot.sh`.
1. Install ROS by executing `bash 1_setup_ros.sh`.
1. You can now enter the chroot by executing `bash run_bash.sh` or `bash run_tmux.sh`.
1. For more information on tmux read the tmux(1) man page.
1. If there are any problems: good luck, DuckDuckGo is your friend ;)

# Licensing
This is published under WTFPL so feel free to copy, edit and share it.
