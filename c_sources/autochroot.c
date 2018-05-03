#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "chroot_config.h"

int main(int argc, char** argv)
{
    if (argc < 2)
    {
        puts("invalid usage!");
        return 1;
    }

    setuid(0);
    setgid(0);

    chdir(CHROOT_ROOT);
    chroot(CHROOT_ROOT);

    if (!strcmp(argv[1], "bash")) {
        system("/usr/bin/sudo -u " CHROOT_USER " /bin/bash");
    }
    else if (!strcmp(argv[1], "tmux")) {
//        system("/usr/bin/sudo -u " CHROOT_USER " /bin/bash");
    }
    else
    {
        puts("invalid command!");
        return 1;
    }

    return 0;
}
