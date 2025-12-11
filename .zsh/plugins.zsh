# ============================================
# External Plugins
# ============================================

PLUGIN_DIR="$HOME/.zsh/plugins"

# Load zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-autosuggestions.git $PLUGIN_DIR/zsh-autosuggestions
if [[ -f "$PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
fi

# Load zsh-interactive-cd
# git clone https://github.com/changyuheng/zsh-interactive-cd $PLUGIN_DIR/zsh-interactive-cd
if [[ -f "$PLUGIN_DIR/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh" ]]; then
  source "$PLUGIN_DIR/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh"
fi

# Load zsh-syntax-highlighting (MUST BE LAST)
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $PLUGIN_DIR/zsh-syntax-highlighting
if [[ -f "$PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting. zsh" ]]; then
  source "$PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
