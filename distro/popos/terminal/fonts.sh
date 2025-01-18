[ ! -d ~/.local/share/fonts ] && mkdir -p ~/.local/share/fonts/ttf
cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
unzip -j JetBrainsMono.zip -d ~/.local/share/fonts/ttf
rm JetBrainsMono.zip

fc-cache -f -v
cd ~