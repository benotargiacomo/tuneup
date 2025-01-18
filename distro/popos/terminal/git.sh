# Prompt for Git user name and email
read -p "Enter your Git user name: " git_name
read -p "Enter your Git email address: " git_email

# Set Git user name and email
git config --global user.name "$git_name"
git config --global user.email "$git_email"

# Set core settings
git config --global core.editor "nvim"
git config --global core.excludesfile "~/.gitignore"
git config --global core.autocrlf input

# Set diff tool and custom command
git config --global diff.tool "default-difftool"
git config --global difftool.default-difftool.cmd "nvim -d \$LOCAL \$REMOTE"

# Set pull behavior to rebase
git config --global pull.rebase true

# Set default branch to main
git config --global init.defaultBranch "main"

echo "Git configuration has been updated for user '$git_name' ($git_email)."
