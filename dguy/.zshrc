# ~/.zshrc file for zsh interactive shells
# see /usr/share/doc/zsh/examples/zshrc for examples

echo "> Sourcing '~/.zshrc'..."

# Privacy umask
umask 0077

# Keybindings
bindkey '^H' backward-kill-word                 # ctrl + backspace
bindkey '5~' kill-word                          # ctrl + delete
bindkey '^5C' forward-word                      # ctrl + ->
bindkey '^5D' backward-word                     # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history  # page up
bindkey '^[[6~' end-of-buffer-or-history        # page down
bindkey '^[[H' beginning-of-line                # home
bindkey '^[[F' end-of-line                      # end
bindkey '^Z' undo                               # shift + tab (undo last action)

# Command history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Prompt with color
if [[ "$color_prompt" == "yes" ]]; then
    PROMPT='%F{010}%n%f@%F{010}%m%f:%F{012}%~%f%F{008}$%f '
else
    PROMPT='%n@%m:%~$ '
fi
unset color_prompt force_color_prompt

# Terminal title (for xterm/rxvt/etc)
case "$TERM" in
xterm*|rxvt*)
    precmd() {
        print -Pn "\e]0;${debian_chroot:+($debian_chroot)}%n@%m: %~\a"
    }
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions
if [ -f ~/.sh_aliases ]; then
    . ~/.sh_aliases
fi

# Stop error sounds
set bell-style none

echo "< Sourced '~/.zshrc'."