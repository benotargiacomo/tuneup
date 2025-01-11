#!/bin/bash

# Ask for sudo privileges
sudo -v

# Exit immediately if a command exits with a non-zero status
set -e

TUNE_UP='  ______                    __  __
 /_  __/_  ______  ___     / / / /___
  / / / / / / __ \/ _ \   / / / / __ \
 / / / /_/ / / / /  __/  / /_/ / /_/ /
/_/  \____/_/ /_/\___/   \____/ ____/
                             /_/
'

echo -e "$TUNE_UP"

# Update system packages
echo "Updating package lists..."
sudo apt-get update >/dev/null

# Upgrade system packages
echo "Upgrading packages..."
sudo apt-get upgrade -y >/dev/null

# Clone repository
echo "Cloning repository..."
sudo apt-get install -y git >/dev/null
rm -rf ~/.local/share/tuneup
git clone https://github.com/benotargiacomo/tuneup.git ~/.local/share/tuneup >/dev/null 2>&1
