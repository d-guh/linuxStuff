# ~/.bashrc: executed by bash(1) for non-login shells.

# Interactive check
[ -z "$PS1" ] && return

echo "> Sourcing '~/.bashrc'..."

umask 0077

HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Color prompt
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    color_prompt=yes
fi

# Color prompt stuff
# 1; bold
# 31m red
# 92m intense green
# 34m blue
# 91m intense red
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\e[1;31m\]\u\[\e[1;00m\]@\[\e[1;92m\]\h\[\e[1;00m\]:\[\e[1;34m\]\w\[\e[1;91m\]\$\[\e[00m\] '

    eval "$(dircolors)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

alias c='cd'
alias v='vim'

alias l='ls -CF'
alias la='ls -aF'
alias ll='ls -lF'
alias lla='ls -laF'

alias cls='clear'

set bell-style none

echo "< Sourced '~/.bashrc'."
