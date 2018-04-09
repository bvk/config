#!/bin/bash

# Import the zpool from any file in /mnt directory using the following example:
#
#  sudo zpool import -d /mnt data
#

DIRS="$DIRS $HOME/Books"
DIRS="$DIRS $HOME/Documents"
DIRS="$DIRS $HOME/Documents"
DIRS="$DIRS $HOME/Junk"
DIRS="$DIRS $HOME/Maildir"
DIRS="$DIRS $HOME/Music"
DIRS="$DIRS $HOME/Notes"
DIRS="$DIRS $HOME/Office"
DIRS="$DIRS $HOME/Papers"
DIRS="$DIRS $HOME/Passwords"
DIRS="$DIRS $HOME/Pictures"
DIRS="$DIRS $HOME/Pool"
DIRS="$DIRS $HOME/Standards"
DIRS="$DIRS $HOME/Study"
DIRS="$DIRS $HOME/Work"
DIRS="$DIRS $HOME/config"
DIRS="$DIRS $HOME/default.org"
DIRS="$DIRS $HOME/go"
DIRS="$DIRS $HOME/opt"
DIRS="$DIRS $HOME/zion.sh"

NOW=$(date +%Y-%m-%d-%H-%M-%S)
rsync -a $DIRS /data/backup
sudo zfs snapshot data/backup@$NOW
