#include <stdio.h>
#include <sys/mount.h>
#include <unistd.h>

#include "chroot_config.h"

int main(int argc, char** argv)
{
    setuid(0);
    
    // system(MOUNT " -t proc proc " CHROOT_ROOT "/proc");
    // system(MOUNT " -t sysfs sys " CHROOT_ROOT "/sys");
    // system(MOUNT " -o bind /dev " CHROOT_ROOT "/dev");
    // system(MOUNT " -o bind /tmp " CHROOT_ROOT "/tmp");

    if (mount("proc", CHROOT_ROOT "/proc", "proc", 0, ""))
    {
        perror("mounting proc failed");
        return 1;
    }
    if (mount("sys", CHROOT_ROOT "/sys", "sysfs", 0, ""))
    {
        perror("mounting sys failed");
        return 1;
    }
    if (mount("/dev", CHROOT_ROOT "/dev", "none", MS_BIND, ""))
    {
        perror("mounting dev failed");
        return 1;
    }
    if (mount("/tmp", CHROOT_ROOT "/tmp", "none", MS_BIND, ""))
    {
        perror("mounting tmp failed");
        return 1;
    }

    return 0;
}
