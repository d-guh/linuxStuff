# ~/.zprofile

echo "> Sourcing '~/.zprofile'..."
# Privacy umask
umask 0077

echo "< Sourced '~/.zprofile'."

echo -e "$(cat ~/.welcomemsg_color.txt)"
