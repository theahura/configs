/usr/bin/setxkbmap -option ctrl:nocaps

set -o vi

if pgrep -x "xcape" > /dev/null; then
  echo "xcape running"
else
  xcape -e 'Control_L=Escape'
  echo "xcape started"
fi

alias python=python3.8
alias pip=pip3
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.local/bin

alias ls='ls --color'
export PATH=$PATH:$HOME/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

export EDITOR='vim'
export VISUAL='vim'

# Set the default nvm version. This goes hand in hand with the .nvmrc file.
nvm alias default 19
nvm use
