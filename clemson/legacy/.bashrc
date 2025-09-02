# This file is sourced for interactive bash shells.  Here are some examples of
# an interactive shell being invoked:
#
#   ssh user@host some-command
#   bash
#   su username
#
# However, it is typical (and the default) to source this file in
# ~/.bash_profile, in which case this file is sourced for all interactive and
# login shells.
#
# Defining aliases or functions is typically done in this file.  Exporting
# variables is usually better suited for ~/.bash_profile.
#
# WARNING: It is NOT safe for commands in this file to generate output.  Things
# like sftp and scp will break.
#
# Some sane defaults are set by the Clemson School of Computing staff.  Feel
# free to change or remove them.

# Set the prompt.
PS1='[\t] \u@\h:\w [\#] '

# Keep all of your files not readable or writable by others.  If you commonly
# work in group directories you may want to change this to 026 or 006.
umask 077

# Prevent files from being overwritten by redirection.
# set -o noclobber

# Prompt before removing or overwriting files with common commands.
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

# Common shortcuts for ls.
alias l='ls -CF'
alias ls='ls --color=auto'
alias ll='ls -lF'
alias la='ls -aF'
alias lla='ls -alF'
# Common misspellings for ls.  Uncomment if you want them.
#alias sl="ls" # Steam locomotive better
#alias LS="ls"

# My Custom Aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# STOP THE ERROR SOUNDS
bind 'set bell-style none'