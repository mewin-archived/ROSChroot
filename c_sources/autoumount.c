#include <stdlib.h>
#include <unistd.h>

#include "chroot_config.h"

int main(int argc, char** argv)
{
    setuid(0);

    system(UMOUNT " -l " CHROOT_ROOT "/proc");
    system(UMOUNT " -l " CHROOT_ROOT "/sys");
    system(UMOUNT " -l " CHROOT_ROOT "/dev");
    system(UMOUNT " -l " CHROOT_ROOT "/tmp");

    return 0;
}
