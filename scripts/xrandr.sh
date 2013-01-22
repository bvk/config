#!/bin/bash

INTERNAL="LVDS1"
EXTERNAL="HDMI1 DP1 VGA1"

# Query xrandr to get the current settings!
config=`mktemp`
xrandr -q |& tee $config

# Switch off the internal output and select the first active external output.
for out in $EXTERNAL; do
    if grep "$out connected" $config >/dev/null; then
	xrandr --output $out --left-of $INTERNAL --auto
	feh --bg-fill ${HOME}/config/feh/wallpaper
	rm $config
	exit 0
    fi
done

# Select the internal output and adjust the wallpaper.
for out in $EXTERNAL; do
    xrandr --output $out --off
done
xrandr --output $INTERNAL --auto
feh --bg-fill ${HOME}/config/feh/wallpaper

rm $config
exit 0
