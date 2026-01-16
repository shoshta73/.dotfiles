#!/usr/bin/env bash
set -euo pipefail

source "$HOME/.bash/colors"
source "$HOME/.bash/variables"

readonly GO_VERSION="1.25.6"
readonly GO_URL="https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"
# Update this version periodically to avoid installation failures
readonly ELEMENT_VERSION="1.12.8"
readonly ELEMENT_URL="https://packages.element.io/desktop/install/linux/glibc-x86-64/element-desktop-${ELEMENT_VERSION}.tar.gz"
readonly NEOVIM_REPO="https://github.com/neovim/neovim"
readonly YAY_REPO="https://aur.archlinux.org/yay.git"
readonly NEOVIM_DIR="$HOME/opt/src/neovim"
readonly YAY_DIR="$HOME/opt/src/yay"
readonly OPT_DIR="$HOME/opt"
readonly LOG_DIR="$HOME/opt"

readonly DIRECTORIES=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/opt/bin"
  "$HOME/opt/src"
)

readonly PACMAN_PACKAGES=(
  git
  clang
  lldb
  gdb
  cmake
  ninja
  curl
  wget
  btop
  tar
  tmux
  fzf
  ripgrep
  starship
  tokei
  eza
  bat
  atuin
  alacritty
  kitty
  neovim
  neovide
  lua
  tldr
  zoxide
  go
)

readonly YAY_PACKAGES=(
  brave-bin
  visual-studio-code-bin
  carapace
)

readonly CARGO_PACKAGES=(
  tree-sitter-cli
)

readonly GO_PACKAGES=(
  github.com/joshmedeski/sesh/v2@latest
)

function log_info() {
  echo -e "[${COLOR_BOLD_GREEN}INFO${COLOR_RESET}] $1"
}

function log_error() {
  echo -e "[${COLOR_BOLD_RED}ERROR${COLOR_RESET}] $1"
}

function run_with_log() {
  local name="$1"
  local log_file="$2"
  shift 2

  log_info "$name"
  "$@" > "$log_file" 2>&1 && {
    log_info "$name completed"
    rm -f "$log_file"
  } || {
    log_error "Failed to $name. See $log_file"
    exit 1
  }
}

function create_directories() {
  for dir in "${DIRECTORIES[@]}"; do
    if [ ! -d "$dir" ]; then
      log_info "Creating $dir directory"
      mkdir -p "$dir"
    else
      log_info "$dir directory already exists"
    fi
  done
}

function install_pacman_packages() {
  for pkg in "${PACMAN_PACKAGES[@]}"; do
    if command -v "$pkg" &> /dev/null; then
      log_info "$pkg is already installed"
    else
      run_with_log "Installing $pkg" "$LOG_DIR/pacman.install.log" \
        sudo pacman -S --needed --noconfirm "$pkg"
    fi
  done
}

function install_yay_packages() {
  for pkg in "${YAY_PACKAGES[@]}"; do
    local exe
    case "$pkg" in
      brave-bin) exe="brave" ;;
      visual-studio-code-bin) exe="code" ;;
      *) exe="$pkg" ;;
    esac
    if command -v "$exe" &> /dev/null; then
      log_info "$pkg is already installed"
    else
      run_with_log "Installing $pkg" "$LOG_DIR/yay.$pkg.install.log" \
        yay -S --needed --noconfirm "$pkg"
    fi
  done
}

function install_cargo_packages() {
  for pkg in "${CARGO_PACKAGES[@]}"; do
    local exe
    case "$pkg" in
      tree-sitter-cli) exe="tree-sitter" ;;
      *) exe="$pkg" ;;
    esac
    if command -v "$exe" &> /dev/null; then
      log_info "$pkg is already installed"
    else
      run_with_log "Installing $pkg" "$LOG_DIR/cargo.install.log" \
        cargo install "$pkg" --locked
    fi
  done
}

function install_go_packages() {
  for pkg in "${GO_PACKAGES[@]}"; do
    local exe="${pkg##*/}"
    exe="${exe%%@*}"
    if command -v "$exe" &> /dev/null; then
      log_info "$pkg is already installed"
    else
      run_with_log "Installing $pkg" "$LOG_DIR/go.install.log" \
        go install "$pkg"
    fi
  done
}

function install_go() {
  log_info "Installing go"
  pushd "$OPT_DIR" > /dev/null

  run_with_log "Downloading go" "$LOG_DIR/go.download.log" \
    wget -q "$GO_URL"

  run_with_log "Extracting go" "$LOG_DIR/go.extract.log" \
    tar -xf "go${GO_VERSION}.linux-amd64.tar.gz"

  rm -f "go${GO_VERSION}.linux-amd64.tar.gz"

  popd > /dev/null
}

function install_rust() {
  run_with_log "Installing rust" "$LOG_DIR/rust.install.log" \
    bash -c "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path"
}

function install_bun() {
  local output
  if ! output=$(curl -fsSL https://bun.sh/install | bash 2>&1); then
    log_error "Failed to install bun"
    echo "$output"
    exit 1
  fi
  log_info "bun installed successfully"
}

function install_uv(){
  run_with_log "Installing uv" "$LOG_DIR/uv.install.log" \
    bash -c "curl -LsSf https://astral.sh/uv/install.sh | sh"
    bash -c "curl -LsSf https://astral.sh/uv/install.sh | sh"
  log_info "uv installed successfully"
}

function install_element() {
  if command -v element &> /dev/null; then
    log_info "element is already installed"
    return
  fi

  log_info "Installing element"
  pushd "$OPT_DIR" > /dev/null

  run_with_log "Downloading element" "$LOG_DIR/element.download.log" \
    wget -q "$ELEMENT_URL"

  run_with_log "Extracting element" "$LOG_DIR/element.extract.log" \
    tar -xf "element-desktop-${ELEMENT_VERSION}.tar.gz"

  if [ ! -d "element-desktop-$ELEMENT_VERSION" ]; then
    log_error "element-desktop-$ELEMENT_VERSION directory not found after extraction"
    exit 1
  fi

  if [ ! -f "element-desktop-$ELEMENT_VERSION/element-desktop" ]; then
    log_error "element-desktop executable not found"
    exit 1
  fi

  run_with_log "Symlinking element" "$LOG_DIR/element.symlink.log" \
    ln -sf "$OPT_DIR/element-desktop-$ELEMENT_VERSION/element-desktop" "$OPT_DIR/bin/element"

  log_info "Cleaning up element tarball"
  rm -f "element-desktop-${ELEMENT_VERSION}.tar.gz"

  popd > /dev/null
}

create_directories
install_pacman_packages

install_go
install_rust

# Just in case cargo is not sourced
source "$HOME/.cargo/env"

install_cargo_packages
install_go_packages
install_yay_packages
install_bun
install_element
install_uv
