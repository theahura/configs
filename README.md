Sets up tmux, vimrc, bashrc configs.
Binds capslock to escape (on release) and control (on hold) with appropriate
bindings that use these features. Sets up vundle with some custom vim plugins
for filesystems (nerdtree) and automatic fast pylinting (flake8).

To make this all work...

## Misc

Install nvm: https://github.com/nvm-sh/nvm

Install xcape: https://github.com/alols/xcape

Copy brightness\_\*.sh to /usr/bin/

\*note that you may need to move the files separately into home directory and
then write them in through sudo vim

Go to keyboard --> shortcuts and add /usr/bin/brightness\_\*.sh to new shortcuts.
You may need to change the number of chars being selected in the 'cut' line
depending on what the actual monitor name is.

## Vim.

To set up vim, copy the vimrc file in this repo to ~/.vimrc. This vimrc will set
up automatic formatting as well as a few other niceties like enabling the mouse,
autocomplete, and syntax checking.

There are a few installation steps for plugins.

First install [vundle](https://github.com/VundleVim/Vundle.vim):

`git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`

Next, open up vim and use the :PluginInstall command to install the plugins we
need.

Afterwards, install the right formatter for the language you intend to use.

- For python, install yapf: `pip install yapf`
- For javascript, install prettier: `npm install -g prettier`

For syntax checking, install syntastic.

`cd ~/.vim/bundle && git clone --depth=1 https://github.com/vim-syntastic/syntastic.git`

Next, install the syntax checker for the language you intend to use.

- For python, install flake8: `pip install flake8`
- For js, install eslint: `npm install -g eslint`

Install copilot for autocomplete:

https://github.com/github/copilot.vim
