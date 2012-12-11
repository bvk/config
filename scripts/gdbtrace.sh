#!/bin/bash
gdb -ex 'set height 0' -ex 'bt full' -ex 'thread apply all bt full' -ex quit "$@"
