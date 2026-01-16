# dotfiles

My personal dotfiles.

## Disclaimer

YOU ARE USING MY DOTFILES AT YOUR OWN RISK.
This is my personal dotfiles. I'm not responsible for any damage caused by using them.

Any and each and every pull request will be ignored and automatically closed.

## Usage

### Ensure you have git installed

```bash
sudo pacman -S git
```

```bash
git clone --bare https://github.com/shoshta73/dotfiles.git $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
mkdir -p .dotfiles-backup
dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .dotfiles-backup/{}
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```
