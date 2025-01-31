sudo apt-get install -y ninja-build gettext cmake curl build-essential

cd /tmp && git clone https://github.com/neovim/neovim
cd neovim && git checkout stable && make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB && sudo dpkg -i nvim-linux-x86_64.deb
rm -rf neovim
cd -

