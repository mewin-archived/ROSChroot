#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "chroot_config.h"

int main(int argc, char** argv)
{
    const char* CONFIG_CONTENT = "set-option -g default-command \"chroot " CHROOT_ROOT " /usr/bin/sudo -u " CHROOT_USER " /bin/bash\"\n";
    setuid(0);

    FILE* f = fopen(TMUX_CONF, "w");
    fwrite(CONFIG_CONTENT, 1, strlen(CONFIG_CONTENT), f);
    fclose(f);

    system(TMUX " -f \"" TMUX_CONF "\"");

    return 0;
}
