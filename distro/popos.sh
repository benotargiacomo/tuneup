# Exit immediately if a command exits with a non-zero status
set -e

# Check if GNOME is the current desktop environment
if [[ "$XDG_CURRENT_DESKTOP" != *"GNOME"* ]]; then
    echo "Error: GNOME desktop environment required"
    echo "Current desktop environment: $XDG_CURRENT_DESKTOP"
    exit 1
fi

# Disable sleep and lock screen
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0

echo "Installing essential packages..."
# TODO: Add eza
sudo apt-get install -y \
    fzf fd-find ripgrep bat httpie jq btop tldr unzip curl \
    ninja-build gettext cmake curl build-essential >/dev/null

mkdir -p ~/.config

# Run installers
echo "Running installers..."
for installer in ~/.local/share/tuneup/distro/popos/*.sh; do source $installer; done

# Enable sleep and lock screen
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.session idle-delay 300
