#!/usr/bin/env bash
set -euo pipefail # Exit on error, unset variable, or pipe failure

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# === Source Paths ===
ZSH_DIR_SRC="$REPO_ROOT/.zsh"
ZSHRC_SRC="$REPO_ROOT/all-zshrc-configs/.zshrc"

# === Destination Paths ===
ZSH_DIR_DEST="$HOME/.zsh"
ZSHRC_DEST="$HOME/.zshrc"

# === Git Hooks Directory ===
GIT_HOOKS_DIR="$REPO_ROOT/git-hooks"

timestamp="$(date +%Y%m%d-%H%M%S)"

# Function to install symlinks
install_symlink() {
  local src="$1"
  local dest="$2"

  # Check if the source exists
  if [[ ! -e "$src" ]]; then
    echo "Missing source: $src"
    return 1
  fi

  # Check if the destination is already a symlink to the source
  if [[ -L "$dest" ]] && [[ "$(readlink -f "$dest")" == "$(readlink -f "$src")" ]]; then
    echo "Skipping $dest - already linked."
    return 0
  fi

  # If the destination exists (file or directory), back it up with a timestamp
  if [[ -e "$dest" || -L "$dest" ]]; then
    echo "Backing up $dest..."
    mv "$dest" "$dest.backup-$timestamp"
  fi

  echo "Linking $dest -> $src"
  ln -s "$src" "$dest"
}

echo "Installing Zsh packages..."

# Install Zsh and related packages
sudo pacman -Syu --needed \
  zsh \
  zsh-completions \
  zsh-autosuggestions \
  zsh-syntax-highlighting \
  nvm \
  fzf \
  git \
  ttf-jetbrains-mono-nerd \
  ttf-nerd-fonts-symbols-mono \
  noto-fonts-emoji

echo "Updating font cache..."
fc-cache -fv

# Set up the symlink for .zshrc and .zsh directory
echo "Setting up symlinks for Zsh configuration..."

install_symlink "$ZSHRC_SRC" "$ZSHRC_DEST"
install_symlink "$ZSH_DIR_SRC" "$ZSH_DIR_DEST"

# Install zsh-interactive-cd plugin (manual installation)
ZSH_PLUGIN_DIR="$ZSH_DIR_DEST/plugins"
ZSH_INTERACTIVE_CD_DIR="$ZSH_PLUGIN_DIR/zsh-interactive-cd"

mkdir -p "$ZSH_PLUGIN_DIR"

if [[ ! -d "$ZSH_INTERACTIVE_CD_DIR/.git" ]]; then
  echo "Installing manual Zsh plugins..."
  git clone https://github.com/changyuheng/zsh-interactive-cd.git \
    "$ZSH_INTERACTIVE_CD_DIR"
fi

# Configure global Git hooks (from the repository's git-hooks directory)
if [[ -d "$GIT_HOOKS_DIR" ]]; then
  echo "Configuring global Git hooks..."

  # Make all scripts in the git-hooks directory executable
  find "$GIT_HOOKS_DIR" -maxdepth 1 -type f -exec chmod +x {} +
  # Set the global Git hooks path to the git-hooks directory
  git config --global core.hooksPath "$GIT_HOOKS_DIR"
fi

# Set zsh as the default shell if it's not already
if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
  echo "Setting Zsh as default shell..."
  chsh -s /usr/bin/zsh
  echo "Done."
  echo "Log out and log back in."
  echo "Set your terminal font to: JetBrainsMono Nerd Font"
else
  echo "Zsh is already the default shell."
  echo "Done."
fi
