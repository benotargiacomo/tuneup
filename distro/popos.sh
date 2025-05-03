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
sudo apt-get install -y \
    imagemagick ffmpeg \
    fzf fd-find ripgrep bat httpie jq btop tldr unzip curl build-essential xclip >/dev/null

# eza
sudo apt-get update
sudo apt-get install -y gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt-get update
sudo apt-get install -y eza

mkdir -p ~/.config

# Run installers
echo "Running terminal installers..."
for installer in ~/.local/share/tuneup/distro/popos/terminal/*.sh; do source $installer; done

echo "Running desktop installers..."
for installer in ~/.local/share/tuneup/distro/popos/desktop/*.sh; do source $installer; done

# Enable sleep and lock screen
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.session idle-delay 300
