#!/bin/bash

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

dlfile /tmp/db.deb http://ftp.debian.org/debian/pool/main/d/debootstrap/debootstrap_1.0.97_all.deb
mkdir /opt/debootstrap > /dev/null 2>&1
cd /opt/debootstrap
ar x /tmp/db.deb
tar xf data.tar.gz

mkdir /opt/debian > /dev/null 2>&1

if [ ! -f /opt/debian/bin/bash ] ; then
	DEBOOTSTRAP_DIR=/opt/debootstrap/usr/share/debootstrap /opt/debootstrap/usr/sbin/debootstrap --arch amd64 jessie /opt/debian/ http://ftp.de.debian.org/debian/
	
	cat > /opt/debian/etc/apt/sources.list << 'EOF'
deb http://ftp.de.debian.org/debian/ jessie main non-free contrib
deb-src http://ftp.de.debian.org/debian/ jessie main non-free contrib

deb http://security.debian.org/ jessie/updates main non-free contrib
deb-src http://security.debian.org/ jessie/updates main non-free contrib

deb http://ftp.de.debian.org/debian/ jessie-updates main non-free contrib
deb-src http://ftp.de.debian.org/debian/ jessie-updates main non-free contrib
EOF
fi

cat > /tmp/postinstall.sh << 'EOF'
#!/bin/bash
apt update
yes | apt dist-upgrade
yes | apt install locales
dpkg-reconfigure locales
yes | apt install sudo
useradd -m -G sudo -s /bin/bash user
passwd user
EOF

source _chroot_prelude.sh

chroot /opt/debian /bin/bash --login /tmp/postinstall.sh

source _chroot_epilog.sh

echo "Chroot has been created at /opt/debian."
echo "You can now run enter_chroot.sh to enter the chrooted environment."
echo "Debootstrap has been installed to /opt/debootstrap, you may want to delete it now."
