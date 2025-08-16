# ~/.zshrc
# For root zsh interactive shells

# Privacy umask
umask 0077

# Command history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000

# Color prompt
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

#force_color_prompt="yes"
if [ "$force_color_prompt" = "yes" ]; then
    color_prompt="yes"
fi

# Color prompt stuff
# %B-%b bold
# %F-%f format (color)
# Uses 256 color codes
# 001 red
# 010 intense green
# 012 intense blue
# 009 intense red
# 015 intense wdadahite
if [[ "$color_prompt" == "yes" ]]; then
    PROMPT="[${0#-}] %B%F{001}%n%f@%F{010}%m%f:%F{012}%~%f%F{009}#%f%b "
else
    PROMPT="[${0#-}] %n@%m:%~# "
fi
unset color_prompt force_color_prompt

# Colored commands
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
    alias dmesg='desmg --color'
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

# Keybindings
bindkey '^H' backward-kill-word                 # ctrl + backspace
bindkey '^[[3~' delete-char                     # delete
bindkey '^[[3;5~' kill-word                     # ctrl + delete
bindkey '^[[1;5C' forward-word                  # ctrl + ->
bindkey '^[[1;5D' backward-word                 # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history  # page up
bindkey '^[[6~' end-of-buffer-or-history        # page down
bindkey '^[[H' beginning-of-line                # home
bindkey '^[[F' end-of-line                      # end
bindkey '^Z' undo                               # shift + tab (undo last action)
