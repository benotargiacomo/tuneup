curl -sS https://starship.rs/install.sh | sh >/dev/null 2>&1

[ -f ~/.config/starship.toml ] && mv ~/.config/starship.toml ~/.config/starship.toml.bak
cp ~/.local/share/tuneup/configs/starship.toml ~/.config/starship.toml
