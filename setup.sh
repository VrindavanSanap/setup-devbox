#!/bin/bash

# Change to the home directory
cd ~ || { echo "Failed to change directory"; exit 1; }
# Install tmux
if command -v apt-get &> /dev/null; then
    sudo apt-get update && sudo apt-get install -y tmux || { echo "Failed to install tmux using apt-get"; exit 1; }
elif command -v yum &> /dev/null; then
    sudo yum install -y tmux || { echo "Failed to install tmux using yum"; exit 1; }
elif command -v brew &> /dev/null; then
    brew install tmux || { echo "Failed to install tmux using Homebrew"; exit 1; }
else
    echo "Unable to install tmux. No supported package manager found."
    exit 1
fi

# Clone the Git repository
git clone https://github.com/VrindavanSanap/configuration.git || { echo "Git clone failed"; exit 1; }

# Remove the .git directory to avoid having git-related files in the final directory
rm -rf ./configuration/.git || { echo "Failed to remove .git directory"; exit 1; }

# Move contents from the cloned repository to the home directory
mv ./configuration/* . || { echo "Failed to move files"; exit 1; }

# Source all files in the current directory
for file in *; do
  # Check if the file is a regular file (not a directory) before sourcing
  if [ -f "$file" ]; then
    source "$file" || { echo "Failed to source $file"; exit 1; }
  fi
done

# Remove the now empty configuration directory
rm -rf ./configuration || { echo "Failed to remove configuration directory"; exit 1; }
