case $- in
  *i*) ;;
  *) return ;;
esac

source $HOME/.bash/colors

source $HOME/.bash/variables
source $HOME/.bash/path

source $HOME/.bash/ps1

source $HOME/.bash/aliases

[[ -f $HOME/.cargo/env ]] && source $HOME/.cargo/env

[[ -f $HOME/.bash-preexec.sh ]] && source $HOME/.bash-preexec.sh

if command -v atuin &> /dev/null; then
  eval "$(atuin init bash)"
fi

if command -v starship &> /dev/null; then
  eval "$(starship init bash --print-full-init)"
fi

if command -v fzf &> /dev/null; then
  eval "$(fzf --bash)"
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init bash)"
fi

export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
source <(carapace _carapace)
