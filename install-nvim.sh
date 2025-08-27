set -e

# Install basics.
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

sudo apt update
sudo apt install tmux
sudo apt install curl
sudo apt install silversearcher-ag
sudo apt install xclip  # For copypasting inside nvim

# Python.
sudo apt install python3-pip

# Node and nvm
sudo apt install nodejs
sudo apt install npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash

# Setup.
cd ~
mkdir /home/$USER/code

# xcape.
cd /home/$USER/code
sudo apt-get install git gcc make pkg-config libx11-dev libxtst-dev libxi-dev
git clone https://github.com/alols/xcape.git
cd xcape
make
sudo make install

# nvim setup.
# NerdFont.
# Note: to finish installing this has to be set in the terminal itself.
mkdir -p ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
fc-cache -fv

# Vifm
sudo apt install vifm
# Run all plugin install.
nvim +PluginInstall +qall


# Copy dotfiles.
cd /home/$USER/code
git clone git@github.com:theahura/configs.git
cd configs
cp .tmux.conf ~/.tmux.conf
cp .eslintrc ~/.eslintrc
cp .bashrc ~/.bashrc
cp -R .config ~/.config
cp -R .vifm ~/.vifm
