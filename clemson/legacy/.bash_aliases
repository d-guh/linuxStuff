# .bash_aliases

# Windows Aliases
alias cls="clear"

# Git Multipull
gitmultipull() {
    eval "$(ssh-agent -s)"
    ssh-add -t 300 ~/.ssh/github
    find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;
    ssh-add -d ~/.ssh/github
}

# Cat file with colors/escape chars
ccat() { echo -e "$(cat $1)"; }

md() { pandoc "$1" | lynx -stdin; }

pdf() { pdftotext "$1" - | less; }