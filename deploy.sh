#! /usr/bin/env bash

# Files and directories added here will be symlinked into the current user's home directory. If you want to link some
# portion of a directory you must specify links explicitly for those files and create the containing directory if it
# does not yet exist.
declare -a TARGETS=(".vim"
                    ".vimrc"
                    ".profile"
                    ".bashrc"
                    ".bash_completion"
                    ".bash_prompt"
                    ".bash_logout"
                    ".bashrc.d/alias.bashrc"
                    ".bashrc.d/app_defaults.bashrc"
                    ".bashrc.d/fzf.bashrc"
                    ".bashrc.d/history.bashrc"
                    ".bashrc.d/less.bashrc"
                    ".bashrc.d/shopt.bashrc"
                    ".tmux.conf"
                    ".global_ignore"
                    ".inputrc"
                    ".taskrc"
                    ".config/flake8"
                    ".config/htop"
                    ".config/dunst"
                    ".config/qutebrowser"
                    ".config/termite"
                    ".config/zathura"
                    ".config/user-dirs.dirs"
                    ".config/fontconfig"
                   )

if [ ! "$1" == "--link" ]; then
    echo "Re-run with \'--link\' parameter to execute the below commands:"
else
    read -r -p "Running as $(whoami), continue? [y/N] " RESPONSE
    if [[ ! "$RESPONSE" =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        echo "Aborting..."
        exit 0
    fi
fi

for TARGET in "${TARGETS[@]}"; do
    TARGET_DIR=$(dirname "${HOME:?}/${TARGET}")
    if [ ! -d "${TARGET_DIR}" ]; then
        PRE_CMD="mkdir -p ${TARGET_DIR} && "
    else
        PRE_CMD=""
    fi

    # We need to delete here, instead of use ln --force or directories go inside the target if it exists
    CMD="${PRE_CMD}rm -rf "${HOME:?}/${TARGET:?}" && ln -sv "${PWD}/configs/${TARGET}" "${HOME}/${TARGET}""
    if [ "$1" == "--link" ]; then
        eval "$CMD"
    else
        echo "$CMD"
    fi
done
