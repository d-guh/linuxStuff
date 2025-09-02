# This file is sourced for all bash login shells.  In other words, its contents
# are executed when you first log in to a system.  Here are some examples of an
# interactive shell being invoked:
#
#   ssh user@host
#   bash --login
#   su - username
#
# Exporting variables (e.g. setting PATH) are typically done in this file.
# Defining aliases or functions are usually better suited for ~/.bashrc.
#
# It is safe for the commands in this file to generate output.
#
# Some sane defaults are set by the Clemson School of Computing staff.  Feel
# free to change or remove them.

# Source settings for interactive shells too.
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

echo -e "$(cat ~/.welcomemsg_color.txt)"