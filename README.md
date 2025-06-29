```
git clone --bare <remote_url> ~/.dotfiles/.git
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout -f      # Force-overwrites existing dotfiles
```
