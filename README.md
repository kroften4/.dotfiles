`.install/` wip

setup
```
git clone --bare <remote_url> ~/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout -f      # Force-overwrite existing dotfiles
```

add files from ~/.config/dotfiles/tracked.conf
```
~/scripts/dotfiles-add.sh
```
