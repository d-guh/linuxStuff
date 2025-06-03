# ~/.zprofile

echo "> Sourcing '~/.zprofile'..."
# Privacy umask
umask 0077

echo "< Sourced '~/.zprofile'."

if [ -f ~/.welcomemsg_color.txt ]; then
    echo -e "$(cat ~/.welcomemsg_color.txt)"
fi
