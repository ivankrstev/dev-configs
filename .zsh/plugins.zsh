# ============================================
# External Plugins
# ============================================

# Load nvm (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
if [[ -f "/usr/share/nvm/init-nvm.sh" ]]; then
  source "/usr/share/nvm/init-nvm.sh"
fi

PLUGIN_DIR="$HOME/.zsh/plugins"

# Load zsh-autosuggestions - Arch/CachyOS package
if [[ -f "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Load zsh-interactive-cd - manually installed Git plugin
# git clone https://github.com/changyuheng/zsh-interactive-cd $PLUGIN_DIR/zsh-interactive-cd
if [[ -f "$PLUGIN_DIR/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh" ]]; then
  source "$PLUGIN_DIR/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh"
fi

# Load zsh-syntax-highlighting (MUST BE LAST) - Arch/CachyOS package
if [[ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
