# ============================================
# Zsh Options and Settings
# ============================================

# Enable colors and prompt expansion
autoload -U colors && colors
setopt PROMPT_SUBST

# Enable auto cd (type directory name to cd into it)
setopt AUTO_CD

# Enable extended globbing
setopt EXTENDED_GLOB

# Don't beep
unsetopt BEEP

# Enable zmv for bulk renaming
autoload -U zmv
