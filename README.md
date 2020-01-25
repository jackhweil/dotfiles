# dotfiles
My user specific config files, including my vim plugins as git submodules. The deploy.sh script will create symlinks
from the home folder to this repository.

## Install

```
git clone --recurse-submodules
```
## Deploy

```
./deploy.sh --link
```

This will symlink each config file (ex. .vimrc) or config directory (ex. .config/neomutt) into `$HOME`.

```
./deploy.sh
```

This will execute a dry run, printing out the commands which would be run with the `--link` parameter.

## Required Dependencies
### Bash >= 4.0
- Without this almost everything is rendered useless

### Vim >= 8.0
- Not technically required, but again a lot of the meat here is vim-centric and the vim config itself

## Optional Dependencies
I will only highlight the key ones here, you will find some other config files for things less important to the
experience or that I don't always use.

### tmux
- tmux configuration is included here, and I plan to expand tmux integrations in the near future

### fzf
- Used for adding massive functionality and efficiency to bash, vim, and tmux
- See https://github.com/junegunn/fzf.git
- Also suggested is the extra plugin [fzf.vim](https://github.com/junegunn/fzf.vim) which adds some useful wrappers
  for the very basic vim integration provided in the main repo. The included vimrc uses this plugin but won't break
  without it

### ripgrep
- Very speedy alternative to find/ag/git-grep which is used with fzf heavily here
- See https://github.com/BurntSushi/ripgrep

### qutebrowser
- Vim-centric keyboard based browser
- See https://github.com/qutebrowser

### Other software referenced
- dunst
- flake8
- fontconfig
- htop
- termite
- xdg-user-dirs

## Update

```
git pull --recurse-submodules
git submodule update --recursive --remote
```
