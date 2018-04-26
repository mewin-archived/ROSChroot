#!/bin/bash

source _common.sh

which wget > /dev/null 2>&1
if [ $? -ne 0 ] ; then
	echo "wget is required for debootstrap. Please install it before running this script."
	exit 1
fi

if [ `id -u` -ne 0 ] ; then
	sudo bash "$0" "$@"
	exit
fi

function dlfile
{
	TARGET_FILE="$1"
	SOURCE_FILE="$2"
	if [ -f "$TARGET_FILE" ] ; then
		curl -o "$TARGET_FILE" -z "$TARGET_FILE" "$SOURCE_FILE"
	else
		curl -o "$TARGET_FILE" "$SOURCE_FILE"
	fi
}

MYCD=$(pwd)

dlfile /tmp/db.deb http://ftp.debian.org/debian/pool/main/d/debootstrap/debootstrap_1.0.97_all.deb
mkdir /opt/debootstrap > /dev/null 2>&1
cd /opt/debootstrap
ar x /tmp/db.deb
tar xf data.tar.gz

mkdir -p "$CHROOT_ROOT" > /dev/null 2>&1

if [ ! -f "$CHROOT_ROOT/bin/bash" ] ; then
	DEBOOTSTRAP_DIR=/opt/debootstrap/usr/share/debootstrap /opt/debootstrap/usr/sbin/debootstrap --arch amd64 $DEBIAN_VERSION "$CHROOT_ROOT/" http://ftp.de.debian.org/debian/

	sed s/DEBIAN_VERSION/$DEBIAN_VERSION/g > "$CHROOT_ROOT/etc/apt/sources.list" << 'EOF'
deb http://ftp.de.debian.org/debian/ DEBIAN_VERSION main non-free contrib
deb-src http://ftp.de.debian.org/debian/ DEBIAN_VERSION main non-free contrib

deb http://security.debian.org/ DEBIAN_VERSION/updates main non-free contrib
deb-src http://security.debian.org/ DEBIAN_VERSION/updates main non-free contrib

deb http://ftp.de.debian.org/debian/ DEBIAN_VERSION-updates main non-free contrib
deb-src http://ftp.de.debian.org/debian/ DEBIAN_VERSION-updates main non-free contrib
EOF
fi

sed s/CHROOT_USER/$CHROOT_USER/g > /tmp/postinstall.sh << 'EOF'
#!/bin/bash
apt update
yes | apt dist-upgrade
yes | apt install locales
# dpkg-reconfigure locales
locale-gen
yes | apt install sudo
useradd -m -G sudo -s /bin/bash CHROOT_USER
echo "CHROOT_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/nopasswd
echo "127.0.0.1\t$(hostname)" >> /etc/hosts
EOF

if [ -f "/etc/locale.gen" ] ; then
    cat < /etc/locale.gen > "$CHROOT_ROOT/etc/locale.gen"
elif [ -n "$LC_NAME" ] ; then
    echo "$LC_NAME" > "$CHROOT_ROOT/etc/locale.gen"
else
    echo "de_DE.UTF-8" > "$CHROOT_ROOT/etc/locale.gen"
fi

cd "$MYCD"
source _chroot_prelude.sh

chroot "$CHROOT_ROOT" /bin/bash --login /tmp/postinstall.sh

source _chroot_epilog.sh

echo "Chroot has been created at $CHROOT_ROOT."
echo "You can now run enter_chroot.sh to enter the chrooted environment."
echo "Debootstrap has been installed to /opt/debootstrap, you may want to delete it now."
