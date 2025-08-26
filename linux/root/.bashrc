# ~/.bashrc
# For root bash interactive shells

# Interactive check
case $- in
    *i*) ;;
      *) return;;
esac

# Privacy umask
umask 0077

# Shell options
shopt -s checkwinsize
#shopt -s globstar
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

case "$TERM" in
    xterm-color|*-256color) color_prompt="yes";;
esac

#force_color_prompt="yes"
if [ "$force_color_prompt" = "yes" ]; then
    color_prompt="yes"
fi

# Color prompt stuff
# 1; bold
# 00m reset (white)
# 31m red
# 92m intense green
# 94m intense blue
# 91m intense red
if [ "$color_prompt" = "yes" ]; then
    PS1="[$(basename $BASH)] \[\e[1;31m\]\u\[\e[1;00m\]@\[\e[1;92m\]\h\[\e[1;00m\]:\[\e[1;94m\]\w\[\e[1;91m\]\\$\[\e[00m\] "
else
    PS1="[$(basename $BASH)] \u@\h:\w\\$ "
fi
PS2="> "
PS3="> "
PS4="+ "
unset color_prompt force_color_prompt

# Colored commands
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
    alias dmesg='dmesg --color'
fi

# Anti-mistake aliases
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

# Generic aliases
alias c='cd'
alias v='vim'

alias l='ls -CF'
alias la='ls -aF'
alias ll='ls -lF'
alias lla='ls -laF'

alias cls='clear'
