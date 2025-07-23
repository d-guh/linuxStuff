# ~/.bashrc ROOT
# for bash interactive shells

[[ $- != *i* ]] && return

umask 0077

shopt -s checkwinsize
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

#force_color_prompt=yes
if [ "$force_color_prompt" = yes ]; then
    color_prompt=yes
fi

# Color prompt stuff
# 1; bold
# 31m red
# 92m intense green
# 34m blue
# 91m intense red
if [ "$color_prompt" = yes ]; then
    PS1="[$(basename $BASH)] \[\e[1;31m\]\u\[\e[0;00m\]@\[\e[1;92m\]\h\[\e[0;00m\]:\[\e[1;34m\]\w\[\e[1;91m\]#\[\e[00m\] "
else
    PS1="[$(basename $BASH)] \u@\h:\w# "
fi
PS2="> "
PS3="> "
PS4="+ "
unset color_prompt force_color_prompt

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
    alias dmesg='dmesg --color'
    # alias pacman="pacman --color=auto"
fi

# Avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

alias c='cd'
alias v='vim'
alias vi='vim'

alias l='ls -CF'
alias la='ls -aF'
alias ll='ls -lF'
alias lla='ls -laF'

alias cls='clear'

#[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
#[ -r /usr/share/doc/pkgfile/command-not-found.bash ] && . /usr/share/doc/pkgfile/command-not-found.bash
