#!/bin/bash
set -e

DOTFILES="$HOME/.dotfiles"

# 1. Sync Repository
if [ ! -d "$DOTFILES" ]; then
  git clone https://github.com/dariusgrassi/dotfiles.git "$DOTFILES"
else
  git -C "$DOTFILES" pull
fi

# 2. OS-Specific Dependency Installation
if [[ "$OSTYPE" == "darwin"* ]]; then
  command -v brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew install git curl ripgrep tmux neovim zsh-autosuggestions
else
  sudo apt-get update && sudo apt-get install -y zsh git curl ripgrep tmux
  # Install Neovim AppImage for Linux
  mkdir -p "$HOME/.local/bin"
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
  chmod u+x nvim-linux-x86_64.appimage
  mv nvim-linux-x86_64.appimage "$HOME/.local/bin/nvim"
fi

# 3. Symlink Configurations
echo "Linking configurations..."
mkdir -p "$HOME/.config/ghostty" "$HOME/.zsh/plugins"

# Utility function for clean symlinking
link_file() {
  ln -sf "$1" "$2"
}

# Configs
[[ -d "$DOTFILES/nvim" ]] && rm -rf "$HOME/.config/nvim" && link_file "$DOTFILES/nvim" "$HOME/.config/nvim"
[[ -f "$DOTFILES/Ghostty/config" ]] && link_file "$DOTFILES/Ghostty/config" "$HOME/.config/ghostty/config"
[[ -f "$DOTFILES/tmux/tmux.conf" ]] && link_file "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"
[[ -f "$DOTFILES/zsh/zshrc" ]] && link_file "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"
[[ -f "$DOTFILES/zsh/.p10k.zsh" ]] && link_file "$DOTFILES/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

# 4. Zsh Plugins (Manual clone for Linux/Non-Homebrew)
plugins=(
  "romkatv/powerlevel10k"
  "zsh-users/zsh-syntax-highlighting"
  "zsh-users/zsh-autosuggestions"
)

for plugin in "${plugins[@]}"; do
  name=$(basename "$plugin")
  [[ ! -d "$HOME/.zsh/plugins/$name" ]] && git clone --depth=1 "https://github.com/$plugin.git" "$HOME/.zsh/plugins/$name"
done

# 5. Finalize Shell
[ "$SHELL" != "$(which zsh)" ] && sudo chsh -s "$(which zsh)" "$(whoami)"

echo "Done. Restart Ghostty to apply."
