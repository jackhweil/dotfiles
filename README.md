# dotfiles
My user specific config files, including my vim plugins as git submodules. The deploy.sh script will create symlinks from the home folder to this repository.

## Install

```
git clone --recurse-submodules
```

Optional tools these dotfiles reference/use:
- fzf : https://github.com/junegunn/fzf.git
- ripgrep : https://github.com/BurntSushi/ripgrep
- neomutt: https://github.com/neomutt
- profanity: https://github.com/boothj5/profanity
- qutebrowser: https://github.com/qutebrowser
- termite: https://github.com/thestinger/termite

## Deploy

```
./deploy.sh --link
```

This will symlink each config file (ex. .vimrc) or config directory (ex. .config/neomutt) into `$HOME`.

```
./deploy.sh
```

This will execute a dry run, printing out the commands which would be run with the `--link` parameter.

## Update

```
git pull --recurse-submodules
git submodule update --recursive --remote
```
