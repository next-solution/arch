#!/bin/bash

# Funkcja pobierająca aktualny branch Git
parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/ (\1)/p'
}

# Dodanie konfiguracji do ~/.bashrc
echo "Adding Git branch to Bash prompt..."
echo 'parse_git_branch() {
    git branch 2> /dev/null | sed -n -e "s/^\\* \\(.*\\)/ (\\1)/p"
}

export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "' >> ~/.bashrc

# Załadowanie nowej konfiguracji
echo "Reloading Bash configuration..."
source ~/.bashrc

echo "Setup complete! Your Bash prompt will now display the current Git branch."
