set -e

# Install basics.
sudo apt update
sudo apt install vim-gnome
sudo apt install tmux
sudo apt install curl
sudo apt install silversearcher-ag

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

# Vim.
# Pathogen.
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
# Vundle.
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Plugin install.
vim +PluginInstall +qall
# Formatters.
pip install yapf
sudo npm install -g prettier
# Syntax.
cd ~/.vim/bundle && git clone --depth=1 https://github.com/vim-syntastic/syntastic.git
pip install flake8
sudo npm install -g eslint
# YCM.
sudo apt install build-essential cmake vim-nox python3-dev
sudo apt install mono-complete golang nodejs default-jdk npm
cd ~/.vim/bundle/YouCompleteMe && python3 install.py --all

# Vifm
sudo apt install vifm

# Copy dotfiles.
cd /home/$USER/code
git clone git@github.com:theahura/configs.git
cd configs
cp .vimrc ~/.vimrc
cp .tmux.conf ~/.tmux.conf
cp .eslintrc ~/.eslintrc
cp .bashrc ~/.bashrc
cp -R .config ~/.config
cp -R .vifm ~/.vifm
