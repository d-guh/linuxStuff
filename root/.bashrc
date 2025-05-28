# ~/.bashrc: executed by bash(1) for non-login shells.

# Interactive check
case $- in
    *i*) ;;
      *) return;;
esac

echo "> Sourcing '~/.bashrc'..."

umask 0077

# Color prompt
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    color_prompt=yes
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[31m\]\u\[\033[00m\]@\[\033[92m\]\h\[\033[00m\]:\[\033[94m\]\w\[\033[91m\]\$\[\033[00m\] '

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