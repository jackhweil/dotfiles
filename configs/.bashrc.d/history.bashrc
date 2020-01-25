# history.bashrc
#
# Bash configuration and helpers for history control

# Shell options
shopt -s cmdhist        # try to save multi-line commands as single history entry
shopt -s histappend     # append to history, don't overwrite it

# History options
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
