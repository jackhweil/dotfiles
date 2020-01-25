# .profile
#
# This file is source by /bin/sh or any /bin/sh derivative so must be /bin/sh compatible and not bash (or zsh, ksh, etc.
# specific).

# Helper functions for working with environment variables like PATH (colon separated directory lists)
#
# Example: path_append LD_LIBRARY_PATH /path/that/exists
path_remove ()  {
    eval VALUE=\$"$1"
    eval "export $1=$(echo -n "$VALUE" | awk -v RS=: -v ORS=: '$0 != "'"$2"'"' | sed 's/:$//')"
}

path_append() {
    eval VALUE=\$"$1"
    if [ -d "$2" ] && [[ ":$VALUE:" != *":$2:"* ]]; then
        path_remove "$1" "$2"
        eval "export $1=$VALUE:$2"
    fi
}

path_prepend() {
    eval VALUE=\$"$1"
    if [ -d "$2" ] && [[ ":$VALUE:" != *":$2:"* ]]; then
        path_remove "$1" "$2"
        eval "export $1=$2:$VALUE"
    fi
}

# Export these functions since they're nice to have
export -f path_remove
export -f path_append
export -f path_prepend

# Note the use of path_prepend to prefer local installations of some software
path_prepend PATH /home/jweil/bin
path_prepend PATH /home/jweil/.local/bin

# Now source our Bash specifics if being run by bash
if [ "$BASH" ]; then
    # shellcheck disable=SC1090
    . ~/.bashrc
fi
