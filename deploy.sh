#! /usr/bin/env bash

# Files and directories added here will be symlinked into the current user's home directory
declare -a TARGETS=(".vim"
                    ".vimrc"
                    ".bashrc"
                    ".bash_profile"
                    ".bash_completion"
                    ".tmux.conf"
                    ".global_ignore"
                    ".inputrc"
                    ".taskrc"
                    ".config/flake8"
                    ".config/neomutt"
                    ".config/profanity"
                    ".config/qutebrowser"
                    ".config/termite"
                    ".config/zathura"
                   )

if [ "jweil" != "$(whoami)" ]; then
	echo "You aren't jweil... be careful"
	exit 1
fi

if [ ! "$1" == "--link" ]; then
    echo "Re-run with \'--link\' parameter to execute the below commands:"
fi

for TARGET in "${TARGETS[@]}"; do
    # We need to delete here, instead of use ln --force or directories go inside the target if it exists
    CMD="rm -rf "${HOME:?}/${TARGET:?}" && ln -sv "${PWD}/configs/${TARGET}" "${HOME}/${TARGET}""
    if [ "$1" == "--link" ]; then
        eval "$CMD"
    else
        echo "$CMD"
    fi
done
