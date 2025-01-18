[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.bak
cp ~/.local/share/tuneup/configs/bashrc ~/.bashrc

[ -f ~/.inputrc ] && mv ~/.inputrc ~/.inputrc.bak
cp ~/.local/share/tuneup/configs/inputrc ~/.inputrc

source ~/.bashrc
