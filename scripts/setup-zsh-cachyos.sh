#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

ZSH_DIR_SRC="$ROOT_ROOT/.zsh"
ZSHRC_SRC="$ROOT_ROOT/all-zshrc-configs/.zshrc"

ZSH_DIR_DEST="$HOME/.zsh"
ZSHRC_DEST="$HOME/.zshrc"

echo "Installing Zsh packages..."

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

echo "Backing up existing Zsh config if present..."

timestamp="$(date +%Y%m%d-%H%M%S)"

if [[ -f "$HOME/.zshrc" ]]; then
  cp "$HOME/.zshrc" "$HOME/.zshrc.backup-$timestamp"
fi

if [[ -d "$HOME/.zsh" ]]; then
  cp -a "$HOME/.zsh" "$HOME/.zsh.backup-$timestamp"
fi

echo "Copying Zsh config..."

cp "$ZSHRC_SRC" "$ZSHRC_DEST"

rm -rf "$ZSH_DIR_DEST"
cp -a "$ZSH_DIR_SRC" "$ZSH_DIR_DEST"

echo "Installing manual Zsh plugins..."

mkdir -p "$ZSH_DIR_DEST/plugins"

if [[ ! -d "$ZSH_DIR_DEST/plugins/zsh-interactive-cd" ]]; then
  git clone https://github.com/changyuheng/zsh-interactive-cd.git \
    "$ZSH_DIR_DEST/plugins/zsh-interactive-cd"
fi

echo "Setting Zsh as default shell..."

if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
  chsh -s /usr/bin/zsh
fi

echo "Done."
echo "Log out and log back in."
echo "Set your terminal font to: JetBrainsMono Nerd Font"
