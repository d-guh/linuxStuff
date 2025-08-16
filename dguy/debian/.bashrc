# ~/.bashrc
# For bash interactive shells

# Interactive check
case $- in
    *i*) ;;
      *) return;;
esac

# Privacy umask
umask 0077

# Shell options
# Window resizing
shopt -s checkwinsize
# Globbin it (**)
shopt -s globstar

# History options
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# Color prompt
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
# 92m intense green
# 94m intense blue
# 90m intense black (gray)
if [ "$color_prompt" = "yes" ]; then
    PS1="[${0#-}] \[\e[1;92m\]\u\[\e[1;00m\]@\[\e[1;92m\]\h\[\e[1;00m\]:\[\e[1;94m\]\w\[\e[1;90m\]\\$\[\e[00m\] "
else
    PS1="[${0#-}] \u@\h:\w\\$ "
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

# Alias definitions
if [ -f ~/.sh_aliases ]; then
    source ~/.sh_aliases
fi

[ -r /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion
