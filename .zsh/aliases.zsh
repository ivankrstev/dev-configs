# ============================================
# Aliases(zsh)
# ============================================

# Load Git aliases from separate file (if it exists)
if [[ -f "$ZSH_CONFIG/gitaliases.zsh" ]]; then
  source "$ZSH_CONFIG/gitaliases.zsh"
else
  echo "Warning: Git aliases file '$ZSH_CONFIG/gitaliases.zsh' not found."
fi

# ls aliases using eza
alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing (long format with hidden files)
alias la='eza -a --color=always --group-directories-first --icons'  # all files and dirs (grid format)
alias ll='eza -l --color=always --group-directories-first --icons'  # long format without hidden files and dirs
alias lt='eza -aT --color=always --group-directories-first --icons --ignore-glob=".git"' # tree listing (ignore .git directory)
alias l.="eza -a1 --icons --group-directories-first -d .*" # show only dotfiles (both files and dirs)
alias lsd='eza -al --color=always --group-directories-first --icons --only-dirs' # list only all directories (no files)
alias lsf='eza -al --color=always --group-directories-first --icons --only-files' # list only all files (no dirs)

# === General Aliases ===
alias c='clear'
alias clear='clear'
alias cls='clear'
alias e='exit'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias h='history'
alias hs='history | grep'
alias hsi='history | grep -i'
alias update='sudo pacman -Syu' # Update system packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)' # Cleanup orphaned packages

# === Journalctl Aliases ===
# Follow journalctl messages in real-time
alias jerr='journalctl -p err -f' # Follow the error messages in real-time
alias jwarn='journalctl -p warning -f' # Follow the warning messages in real-time
alias jinfo='journalctl -p info -f' # Follow the info messages in real-time
alias jall='journalctl -f' # Follow all messages in real-time

# Show error messages from the current boot
alias jerrb='journalctl -p err -b' # Show error messages from the current boot
alias jwarnb='journalctl -p warning -b' # Show warning messages from the current boot
alias jinfob='journalctl -p info -b' # Show info messages from the current boot
alias jallb='journalctl -b' # Show all messages from the current boot
