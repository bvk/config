#!/bin/bash
mplayer -novideo -channels 6 -af channels=6:6:0:0:1:1:0:2:1:3,lavcac3enc=1:448:2 -ao alsa:device=hw=1.3 -afm hwac3 "$@"
