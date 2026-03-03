# ============================================
# Aliases(zsh)
# ============================================

# Load Git aliases from separate file (if it exists)
if [[ -f "$ZSH_CONFIG/gitaliases.zsh" ]]; then
  source "$ZSH_CONFIG/gitaliases.zsh"
else
  echo "Warning: Git aliases file '$ZSH_CONFIG/gitaliases.zsh' not found."
fi

# === General Aliases ===
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias h='history'
alias hs='history | grep'
alias hsi='history | grep -i'
