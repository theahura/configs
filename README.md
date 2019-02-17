Sets up tmux, vimrc, bashrc configs.
Binds capslock to escape (on release) and control (on hold) with appropriate
bindings that use these features. Sets up vundle with some custom vim plugins
and some linting.


To make this all work...

Install Vundle: https://github.com/VundleVim/Vundle.vim
	and run :PluginInstall in vim.

Install flake8: https://pypi.org/project/flake8/
	likely in a virtualenv

Install xcape: https://github.com/alols/xcape

Install eslint with  npm install eslint --global
