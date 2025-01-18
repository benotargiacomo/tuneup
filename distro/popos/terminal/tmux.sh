sudo apt-get install -y tmux >/dev/null 2>&1

[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.bak
cp ~/.local/share/tuneup/configs/tmux.conf ~/.tmux.conf

mkdir -p ~/code/personal ~/code/work ~/code/github

[ ! -d ~/.local/bin ] && mkdir -p ~/.local/bin
cp ~/.local/share/tuneup/scripts/tmux-sessionizer ~/.local/bin/sss
chmod +x ~/.local/bin/sss
