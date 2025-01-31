sudo apt-get install -y ninja-build gettext cmake curl build-essential

cd /tmp && git clone https://github.com/neovim/neovim
cd neovim && git checkout stable && make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB && sudo dpkg -i nvim-linux-x86_64.deb

# cd /tmp
# wget -O nvim.tar.gz "https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz"
# tar -xf nvim.tar.gz
# sudo install nvim-linux64/bin/nvim /usr/local/bin/nvim
# sudo cp -R nvim-linux64/lib /usr/local/
# sudo cp -R nvim-linux64/share /usr/local/
# rm -rf nvim-linux64 nvim.tar.gz
# cd -

