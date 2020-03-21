/usr/bin/setxkbmap -option ctrl:nocaps

set -o vi

if pgrep -x "xcape" > /dev/null; then
  echo "xcape running"
else
  xcape -e 'Control_L=Escape'
  echo "xcape started"
fi
