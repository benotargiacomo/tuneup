#!/bin/bash

# Ask for sudo privileges
echo "This script requires root privileges."
sudo -v

# Exit immediately if a command exits with a non-zero status
set -e

TUNE_UP='  ______                    __  __
 /_  __/_  ______  ___     / / / /___
  / / / / / / __ \/ _ \   / / / / e_ \
 / / / /_/ / / / /  __/  / /_/ / /_/ /
/_/  \____/_/ /_/\___/   \____/ ____/
                             /_/
'

echo -e "$TUNE_UP"

# Update system packages
echo -n "Updating package lists... "
sudo apt-get update > /dev/null
echo "Done!"

# Upgrade system packages
echo -n "Upgrading installed packages..."
sudo apt-get upgrade -y > /dev/null
echo "Done"!
