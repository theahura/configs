set -e

# Install basics.

if ! command -v vim &> /dev/null
then
  echo "Vim is not installed. Installing..."
  sudo add-apt-repository ppa:jonathonf/vim

  sudo apt update
  sudo apt install -y vim-gnome tmux curl silversearcher-ag
else
    echo "Vim is already installed."
fi

# Python.
sudo apt install -y python3-pip

# Node and nvm
sudo apt install -y nodejs npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
source ~/.bashrc
# nvm install 17

# Setup.
cd ~
mkdir -p /home/$USER/code

# xcape.
cd /home/$USER/code
sudo apt-get install git gcc make pkg-config libx11-dev libxtst-dev libxi-dev
if ! git clone https://github.com/alols/xcape.git xcape 2>/dev/null && [ -d "xcape" ] ; then
    echo "Clone failed because the folder xcape exists"
fi
cd xcape
make
sudo make install

# Vim.
# Pathogen.
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
# Vundle.
cd /home/$USER/.vim/bundle
if ! git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 2>/dev/null && [ -d "Vundle.vim" ] ; then
    echo "Clone failed because the folder Vundle exists"
fi
# Plugin install.
vim +PluginInstall +qall

# YCM.
sudo apt install -y build-essential cmake vim-nox python3-dev mono-complete golang nodejs default-jdk npm
cd ~/.vim/bundle/YouCompleteMe && python3 install.py

# Vifm
sudo apt install -y vifm

# Copy dotfiles.
cd /home/$USER/code
if ! git clone git@github.com:theahura/configs.git configs 2>/dev/null && [ -d "configs" ] ; then
    echo "Clone failed because the folder configs exists"
fi
cd configs
cp .vimrc ~/.vimrc
cp .tmux.conf ~/.tmux.conf
cp .eslintrc ~/.eslintrc
cp .bashrc ~/.bashrc
cp .nvmrc ~/.nvmrc
cp -R .config ~/.config
cp -R .vifm ~/.vifm
