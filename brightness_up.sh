#!/bin/bash

CURRBRIGHT=$(xrandr --current --verbose | grep -m 1 'Brightness:' | cut -f2- -d:)
NEWBRIGHT=$(echo "$CURRBRIGHT + 0.1" | bc)
DISPLAYS=$(xrandr --current --verbose | grep ' connected' | cut -c 1-4)

for display in $DISPLAYS; do
echo $NEWBRIGHT
xrandr --output $display --brightness $NEWBRIGHT
done
