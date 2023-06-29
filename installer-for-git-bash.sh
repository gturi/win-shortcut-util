#!/bin/bash

# gets the absolute path to directory containing this script
DIR=$(dirname "$(readlink -f "$0")")

SCRIPT="$DIR/git-bash-shortcut-utils.sh"

if [ -f "$SCRIPT" ]; then
    # adds to .bashrc
    # sourceIfExists "$SCRIPT\"
    printf '\n%s\n' \
        "sourceIfExists \"$SCRIPT\"" \
        >> "$HOME/.bashrc"
fi
