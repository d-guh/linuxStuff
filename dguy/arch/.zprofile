# ~/.zprofile

# Privacy umask
umask 0077

if [ -f ~/.welcomemsg_color ]; then
    echo -e "$(cat ~/.welcomemsg_color)"
fi
