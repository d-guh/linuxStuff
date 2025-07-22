# ~/.bashrc
# for bash interactive shells

[[ $- != *i* ]] && return

# Privacy umask
umask 0077

# Window resizing
shopt -s checkwinsize

# History settings
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
# 92m intense green
# 94m intense blue
# 90m intense black (gray)
if [ "$color_prompt" = yes ] ; then
    PS1="[$(basename "$0")] \[\e[1;92m\]\u\[\e[1;00m\]@\[\e[1;92m\]\h\[\e[1;00m\]:\[\e[1;94m\]\w\[\e[1;90m\]\$\[\e[00m\] "
else
    PS1="[$(basename "$0")] \u@\h:\w\$ "
fi
PS2="> "
PS3="> "
PS4="+ "
unset color_prompt force_color_prompt

# Colored commands
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls="ls --color=auto"
    alias dir="dir --color=auto"
    alias grep="grep --color=auto"
    alias dmesg='dmesg --color'
    # alias pacman="pacman --color=auto"
fi

# Alias definitions
if [ -f ~/.sh_aliases ]; then
    . ~/.sh_aliases
fi

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
[ -r /usr/share/doc/pkgfile/command-not-found.bash ] && . /usr/share/doc/pkgfile/command-not-found.bash
