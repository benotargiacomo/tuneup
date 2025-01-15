sudo apt-get install -y tmux >/dev/null 2>&1

[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.bak
cp ~/.local/share/tuneup/configs/tmux.conf ~/.tmux.conf
