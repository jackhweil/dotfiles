# .bashrc
# Per-shell stuff like aliases, functions, etc.

# Check to make sure we are in an interactive mode shell. Apparently on some systems bash is compiled to source
# .bashrc for non-interactive mode shells which may break some programs depending on our settings.
[[ $- == *i* ]] || return 0

# define this convenience function for sourcing all executable files in a given directory
function include_dir() {
    for f in "$@"; do
        # shellcheck disable=SC1090
        source "$f"
    done
}

# Source global bashrc
if [ -f /etc/bashrc ]; then
    # shellcheck disable=SC1091
    . /etc/bashrc
fi

# Source global bash completions
if [ -d /etc/bash_completion.d ]; then
    include_dir /etc/bash_completion.d/*
fi

# Source extended completion from bash-completion package
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

# Source any local bash completion scripts
if [ -f ~/.bash_completion ]; then
    # shellcheck disable=SC1090
    . ~/.bash_completion
fi

# Customize our prompt
if [ -f ~/.bash_prompt ]; then
    # shellcheck disable=SC1090
    . ~/.bash_prompt
fi

# Source everything else, organized into split files
if [ -d ~/.bashrc.d ]; then
    include_dir ~/.bashrc.d/*.bashrc
fi

# unset this so we don't pollute namespace and its not that useful elsewhere
unset include_dir
