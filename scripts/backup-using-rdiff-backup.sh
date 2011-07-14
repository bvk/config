#!/bin/bash

if test -z "$1" -o -z "$2"
then
    echo "error: source or target directories missing"
    exit 1
fi

rdiff-backup --exclude-globbing-filelist ~/config/rdiff-backup/exclude-filelist --exclude-if-present .no-rdiff-backup $1 $2
sync
