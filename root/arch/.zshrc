# ~/.zshrc ROOT
# for zsh interactive shells

umask 0077

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# force_color_prompt=yes
if [ "$force_color_prompt" = yes ]; then
    color_prompt=yes
fi

# Color prompt stuff
# %B-%b bold
# %F-%f format (color)
# 001 red
# 010 intense green
# 004 blue
# 009 intense red
# 015 intense white
if [[ "$color_prompt" == "yes" ]]; then
    PROMPT="[$ZSH_NAME] %B%F{001}%n%f%b%F{015}@%f%B%F{010}%m%f%b%F{015}:%f%B%F{004}%~%f%F{009}#%f%b "
else
    PROMPT="[$ZSH_NAME] %n@%m:%~# "
fi
PROMPT2="> "
PROMPT3="> "
PROMPT4="+ "
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
    alias dmesg='desmg --color'
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

#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#source /usr/share/doc/pkgfile/command-not-found.zsh
