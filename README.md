Sets up tmux, vimrc, bashrc configs.
Binds capslock to escape (on release) and control (on hold) with appropriate
bindings that use these features. Sets up vundle with some custom vim plugins
for filesystems (nerdtree) and automatic fast pylinting (flake8).

To make this all work...

Install Vundle: https://github.com/VundleVim/Vundle.vim
and run :PluginInstall in vim.

Install pathogen: https://gist.github.com/romainl/9970697
Install vim-prettier: https://github.com/prettier/vim-prettier (remember npm install step)

Install syntastic: https://github.com/vim-syntastic/syntastic

Install flake8: https://pypi.org/project/flake8/
likely in a virtualenv
move flake8 config to ~/.config/flake8

Install xcape: https://github.com/alols/xcape

Copy brightness\_\*.sh to /usr/bin/

\*note that you may need to move the files separately into home directory and
then write them in through sudo vim

Go to keyboard --> shortcuts and add /usr/bin/brightness\_\*.sh to new shortcuts.
You may need to change the number of chars being selected in the 'cut' line
depending on what the actual monitor name is.
