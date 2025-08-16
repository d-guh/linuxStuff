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
