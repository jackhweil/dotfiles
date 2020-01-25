# app_defaults.bashrc
#
# This sets up applicaion defaults via bash environment variables like EDITOR

export EDITOR="vim"
export VISUAL="vim"

if command -v qutebrowser>/dev/null; then
    # shellcheck disable=SC2034,SC2155
    export BROWSER=$(command -v qutebrowser)
elif command -v chromium>/dev/null; then
    # shellcheck disable=SC2034,SC2155
    export BROWSER=$(command -v chromium)
elif command -v firefox>/dev/null; then
    # shellcheck disable=SC2034,SC2155
    export BROWSER=$(command -v firefox)
fi
