sudo apt-get install -y alacritty

sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty

[ ! -d ~/.config/alacritty ] && mkdir -p ~/.config/alacritty

version=$(alacritty --version | cut -d ' ' -f2 | cut -d '.' -f2)

if [ "$version" -ge "13" ]; then
    cp ~/.local/share/tuneup/configs/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
else
    cp ~/.local/share/tuneup/configs/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
fi
