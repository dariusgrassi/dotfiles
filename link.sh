#!/bin/bash
set -e

check_command() {
  if ! command -v "$1" &>/dev/null; then
    echo "Error: $1 is not installed. Installing..."
    if command -v apt-get &>/dev/null; then
      sudo apt-get update
      sudo apt-get install -y "$1"
    elif command -v yum &>/dev/null; then
      sudo yum install -y "$1"
    elif command -v pacman &>/dev/null; then
      sudo pacman -S --noconfirm "$1"
    else
      echo "Cannot install $1. Please install it manually."
      exit 1
    fi
  fi
}

check_command zsh
check_command git
check_command curl

# because packages names != command names
sudo apt-get install -y neovim ripgrep

# link neovim configs
# Install latest Neovim using AppImage
install_neovim() {
    echo "Installing latest Neovim using AppImage..."
    mkdir -p "$HOME/.local/bin"
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
    chmod u+x nvim-linux-x86_64.appimage
    mv nvim-linux-x86_64.appimage "$HOME/.local/bin/nvim"
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
    fi
    echo "Neovim installed successfully!"
}

# Link Neovim configuration files
echo "Setting up Neovim configs..."
if [ -d "$HOME/.dotfiles/nvim" ]; then
    mkdir -p "$HOME/.config"
    rm -rf "$HOME/.config/nvim"
    ln -sf "$HOME/.dotfiles/nvim" "$HOME/.config/nvim"
    install_neovim
    echo "Neovim configuration linked successfully."
else
    echo "Warning: Neovim configuration not found in dotfiles."
fi

# Install LazyVim
if [ ! -f "$HOME/.config/nvim/lazy-lock.json" ]; then
  echo "Setting up LazyVim plugin manager..."
  # First launch of Neovim will install plugins
  nvim --headless "+Lazy sync" +qa || echo "Plugin installation will complete on first launch"
fi
else
  echo "Warning: Neovim configuration not found in dotfiles."
fi

# download my dotfiles
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

# Create ZSH plugin directory
mkdir -p "$HOME/.zsh/plugins"

# download powerlevel10k prompt theme
if [ ! -d "$HOME/.zsh/plugins/powerlevel10k" ]; then
  echo "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.zsh/plugins/powerlevel10k"
fi

# download zsh-syntax-highlighting
if [ ! -d "$HOME/.zsh/plugins/zsh-syntax-highlighting" ]; then
  echo "Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh/plugins/zsh-syntax-highlighting"
fi

# link my zshrc and p10k configs
echo "Linking zsh configuration files..."
rm -f "$HOME/.zshrc"
ln -sf "$HOME/.dotfiles/zsh/zshrc" "$HOME/.zshrc"

if [ -f "$HOME/.dotfiles/zsh/.p10k.zsh" ]; then
  rm -f "$HOME/.p10k.zsh"
  ln -sf "$HOME/.dotfiles/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
fi

# Try to set zsh as the default shell, but don't fail if it doesn't work
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "Attempting to set zsh as default shell..."
  which zsh | sudo tee -a /etc/shells >/dev/null 2>&1 || true
  sudo chsh -s "$(which zsh)" "$(whoami)"|| echo "Could not change shell automatically. You may need to run 'chsh -s $(which zsh)' manually."
  echo "Note: You'll need to log out and back in for the shell change to take effect."
fi

echo "Setup complete! Starting zsh..."
exec zsh -l
