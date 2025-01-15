sudo apt install -y tmux

[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.bak
cp ~/.local/share/tuneup/configs/tmux.conf ~/.tmux.conf
