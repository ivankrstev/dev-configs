# ============================================
# Pure Zsh Configuration
# Main Configuration Loader
# ============================================

# Define ZSH config directory
export ZSH_CONFIG="$HOME/.zsh"

# Load configuration files in order
config_files=(
  env          # Environment variables (loaded first)
  options      # Zsh options and settings
  history      # History configuration
  completion   # Completion system
  aliases      # Aliases
  functions    # Custom functions
  keybindings  # Key bindings
  plugins      # External plugins (loaded late)
)

# Source each configuration file
for config in $config_files; do
  if [[ -f "$ZSH_CONFIG/$config.zsh" ]]; then
    source "$ZSH_CONFIG/$config.zsh"
  fi
done

unset config_files config

# Load theme (after plugins for proper rendering)
if [[ -f "$ZSH_CONFIG/themes/main.zsh" ]]; then
  source "$ZSH_CONFIG/themes/main.zsh"
fi

# Load local configuration if it exists (last)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
