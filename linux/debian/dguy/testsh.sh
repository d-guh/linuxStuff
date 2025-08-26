# NOTE: Either execute with 'SHELL testsh.sh' or source to use current shell, or will likley use system default (sh/dash)
echo "Gathering shell info..."
echo "\nGenerics:" # Generics
echo "\$0:                     $0" # Current process
echo "\$SHELL:                 $SHELL" # Specified login shell
echo "ps -p \$\$ -o 'comm=':    $(ps -p $$ -o 'comm=')" # Current shell (fairly reliable)
echo "readlink /proc/\$\$/exe:  $(readlink /proc/$$/exe)" # Analog method if ps is unavailable
echo "\nShell Specific:" # Shell Specific
echo "\$version:               $version"
echo "\$BASH:                  $BASH"
echo "\$shell:                 $shell"
echo "\$ZSH_NAME:              $ZSH_NAME"

# I'd prefer to use the shell specific ones if able, but tools like su when doing a login shell can be quite picky
# For example, if you're trying to 'sudo su root -l -s /bin/bash' but roots login shell in /etc/passwd is: '/usr/sbin/nologin'
# It will display: [nologin] root@dguyserv:~# , even though the current shell IS BASH
# This kinda sucks and I'm about to either use ps or hardcode it tbh
