# ============================================
# Pure Zsh Configuration
# Main Configuration Loader
# ============================================

# Define ZSH config files directory
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
  else
    echo "Warning: Config file '$ZSH_CONFIG/$config.zsh' not found."
  fi
done

unset config_files config

# Load theme (after plugins for proper rendering)
if [[ -f "$ZSH_CONFIG/themes/main.zsh" ]]; then
  source "$ZSH_CONFIG/themes/main.zsh"
else
  echo "Warning: Theme file '$ZSH_CONFIG/themes/main.zsh' not found."
fi

# Load local configuration if it exists (last)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
