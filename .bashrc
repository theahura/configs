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
