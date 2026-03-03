# ============================================
# History Configuration
# ============================================

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_ALL_DUPS # Remove older duplicates from history
setopt HIST_FIND_NO_DUPS # Don't display duplicates in history search
setopt SHARE_HISTORY # Share history across all sessions
setopt APPEND_HISTORY # Append to history file instead of overwriting
setopt INC_APPEND_HISTORY # Write to history file immediately, not when shell exits
