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

# Checking distro
DISTRO=$(cat /etc/os-release | grep -oP '(?<=^ID=).+' | tr -d '"')

if [ -z "$DISTRO" ]; then
    echo "Error: Could not determine distribution"
    exit 1
fi

case "$DISTRO" in
"arch")
    echo "Starting installation for Arch..."

    # Installs yay if not installed
    command -v yay >/dev/null 2>&1 || sudo pacman -S --noconfirm yay

    # Update System
    echo "Updating system..."
    yay -Syyuu --noconfirm >/dev/null 2>&1

    # Clone repository
    echo "Cloning repository..."
    command -v git >/dev/null 2>&1 || sudo pacman -S --noconfirm git
    rm -rf ~/.local/share/tuneup
    git clone https://github.com/benotargiacomo/tuneup.git ~/.local/share/tuneup >/dev/null 2>&1

    source ~/.local/share/tuneup/distro/arch.sh
    ;;
"pop")
    echo "Starting installation for Pop!_OS..."

    # Update system packages
    echo "Updating system..."
    sudo apt-get update >/dev/null
    sudo apt-get upgrade -y >/dev/null

    # Clone repository
    echo "Cloning repository..."
    command -v git >/dev/null 2>&1 || sudo apt-get install -y git >/dev/null
    rm -rf ~/.local/share/tuneup
    git clone https://github.com/benotargiacomo/tuneup.git ~/.local/share/tuneup >/dev/null 2>&1

    source ~/.local/share/tuneup/distro/pop.sh
    ;;
*)
    echo "Error: Unsupported distribution: $DISTRO"
    exit 1
    ;;
esac
