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
git clone --bare https://github.com/shoshta73/.dotfiles.git "$HOME/.dotfiles"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

mkdir -p "$HOME/.dotfiles-backup"

dotfiles checkout 2>&1 | grep -E "\s+\." | awk '{print $1}' | while read file; do
  mkdir -p "$HOME/.dotfiles-backup/$(dirname "$file")"
  mv "$file" "$HOME/.dotfiles-backup/$file"
done

dotfiles checkout
dotfiles config --local status.showUntrackedFiles no

./install.sh

```

Install script is based on endeavouros base install which commes with yay installed.
