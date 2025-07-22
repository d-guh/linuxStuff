# ~/.zprofile

echo "> Sourcing '~/.zprofile'..."
# Privacy umask
umask 0077

echo "< Sourced '~/.zprofile'."

if [ -f ~/.welcomemsg_color ]; then
    echo -e "$(cat ~/.welcomemsg_color)"
fi
