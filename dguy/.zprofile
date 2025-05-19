# ~/.zprofile

echo "> Sourcing '~/.zprofile'..."
# Privacy umask
umask 0377

echo "< Sourced '~/.zprofile'."

echo -e "$(cat ~/.welcomemsg_color.txt)"
