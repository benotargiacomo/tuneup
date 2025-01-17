# https://www.jetbrains.com/lp/mono/

[ ! -d ~/.local/share/fonts ] && mkdir -p ~/.local/share/fonts
unzip ~/.local/share/tuneup/configs/fonts/JetBrainsMono-2.304.zip -d ~/.local/share/fonts

fc-chache -f -v
