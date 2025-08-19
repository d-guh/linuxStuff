# ~/.zshrc
# For zsh interactive shells

# Privacy umask
umask 0077

# History options
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000

# Color prompt
case "$TERM" in
    xterm-color|*-256color) color_prompt="yes";;
esac

#force_color_prompt="yes"
if [ "$force_color_prompt" = "yes" ]; then
    color_prompt="yes"
fi

# Color prompt stuff
# %B-%b bold
# %F-%f format (color)
# Uses 256 color codes
# 010 intense green
# 012 intense blue
# 008 intense black (gray)
# 015 intense white
if [ "$color_prompt" = "yes" ]; then
    PROMPT="[$(ps -p $$ -o comm=)] %B%F{010}%n%f%b%F{015}@%f%B%F{010}%m%f%b%F{015}:%f%B%F{012}%~%f%F{008}$%f%b "
else
    PROMPT="[$(ps -p $$ -o comm=)] %n@%m:%~$ "
fi
PROMPT2="> "
PROMPT3="> "
PROMPT4="+ "
unset color_prompt force_color_prompt

# Colored commands
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
    alias dmesg='desmg --color'
fi

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

# Alias definitions
[ -r ~/.sh_aliases ] && source ~/.sh_aliases

# Fancy zsh features
[ -r /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -r /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
