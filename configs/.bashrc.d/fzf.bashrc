# fzf.bashrc
#
# All fzf related bash aliases, functions, etc

# Have FZF use ripgrep instead of find, respects .gitignore files, follows symlinks, and ignores .git/ contents"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# Enable FZF bash integration (try local install first)

# NOTE: There is a bug (fixed 82bf8c138daaabf28faf7819b2f5a2b03af37d43) which doesn't populate input keymap
# properly, and requires the setting before this is sourced (vs using just inputrc). I am leaving this here
# for compatibility with older versions of fzf.
set -o vi
if [ -f ~/.fzf.bash ]; then
    # shellcheck disable=SC1090
    . ~/.fzf.bash
else
    [ -f /usr/share/fzf/key-bindings.bash ] && . /usr/share/fzf/key-bindings.bash
    [ -f /usr/share/fzf/completion.bash ] && . /usr/share/fzf/completion.bash
fi

# Alias my fzf functions
alias ffo="fzf_find_edit"  # fuzzy find file and open
alias flo="fzf_rg_edit"    # fuzzy find line and open

# Custom fzf functions
fzf_find_edit() {
    local file
    file=$(
    fzf --no-multi --preview 'cat {}'
    )
    if [ -n "$file" ]; then
        eval "$VISUAL $file"
    fi
}

fzf_rg_edit(){
    if [ $# == 0 ]; then
        echo 'Error: search term was not provided.'
        return
    fi
    local match
    match=$(
    rg --color=never --line-number "$1" |
    fzf --preview-window up:1 --no-multi --delimiter : \
        --preview "{}"
    )
    local file
    file=$(echo "$match" | cut -d':' -f1)
    if [ -n "$file" ]; then
        eval "$VISUAL $file +$(echo "$match" | cut -d':' -f2)"
    fi
}
