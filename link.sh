#!/bin/bash
set -e

# note that this script is intended primary for linux machines - use
# with caution on other operating systems

# check if dotfiles exist
if [ ! -d "$HOME/.dotfiles" ]; then
  echo "Cloning dotfiles repository..."
  git clone https://github.com/dariusgrassi/dotfiles.git "$HOME/.dotfiles" || {
    echo "Failed to clone dotfiles repository. Please check access."
    exit 1
  }
else
  echo "Updating dotfiles repository..."
  cd "$HOME/.dotfiles" && git pull
fi

echo "Installing dependencies..."
sudo apt-get update && sudo apt-get install -y \
  zsh \
  git \
  curl \
  ripgrep \
  tmux

# Install latest Neovim
echo "Installing latest Neovim..."
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS path
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)" # M1 Macs
  fi

  echo "Installing Neovim via Homebrew..."
  brew install neovim
else
  # Assume Linux
  mkdir -p "$HOME/.local/bin"
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
  chmod u+x nvim-linux-x86_64.appimage
  mv nvim-linux-x86_64.appimage "$HOME/.local/bin/nvim"

  if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >>"$HOME/.zshrc"
  fi
fi

# Link Neovim configs
echo "Setting up Neovim configs..."
if [ -d "$HOME/.dotfiles/nvim" ]; then
  mkdir -p "$HOME/.config"
  rm -rf "$HOME/.config/nvim"
  ln -sf "$HOME/.dotfiles/nvim" "$HOME/.config/nvim"
  echo "Neovim configuration linked successfully."
else
  echo "Warning: Neovim configuration not found in dotfiles."
fi

# Install LazyVim plugins if needed
if [ -f "$HOME/.config/nvim/lazy-lock.json" ]; then
  echo "LazyVim lock file found, syncing plugins..."
  nvim --headless "+Lazy sync" +qa || echo "Plugin installation will complete on first launch"
fi

# Setup tmux
echo "Setting up tmux configuration..."
if [ -f "$HOME/.dotfiles/tmux/tmux.conf" ]; then
  rm -f "$HOME/.tmux.conf"
  ln -sf "$HOME/.dotfiles/tmux/tmux.conf" "$HOME/.tmux.conf"
  echo "Tmux configuration linked successfully."
else
  echo "Warning: Tmux configuration not found in dotfiles."
fi

# Setup ZSH
echo "Setting up ZSH environment..."
mkdir -p "$HOME/.zsh/plugins"

# Download powerlevel10k prompt theme
if [ ! -d "$HOME/.zsh/plugins/powerlevel10k" ]; then
  echo "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.zsh/plugins/powerlevel10k"
fi

# Download zsh-syntax-highlighting
if [ ! -d "$HOME/.zsh/plugins/zsh-syntax-highlighting" ]; then
  echo "Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh/plugins/zsh-syntax-highlighting"
fi

# Link zsh configuration files
echo "Linking zsh configuration files..."
rm -f "$HOME/.zshrc"
ln -sf "$HOME/.dotfiles/zsh/zshrc" "$HOME/.zshrc"

if [ -f "$HOME/.dotfiles/zsh/.p10k.zsh" ]; then
  rm -f "$HOME/.p10k.zsh"
  ln -sf "$HOME/.dotfiles/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
fi

# Set zsh as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "Setting zsh as default shell..."
  sudo chsh -s "$(which zsh)" "$(whoami)" || echo "Could not change shell. Run 'chsh -s $(which zsh)' manually."
  echo "Note: Log out and back in for shell change to take effect."
fi
