# ============================================
# CUSTOM GIT THEME (mygit)
# ============================================

# === Color Definitions ===
local dir_color="%F{38}"
# === Git Color Definitions ===
local git_branch_color="%F{cyan}"      # Cyan
local git_clean_color="%F{green}"      # Green
local git_sync_color="%F{yellow}"      # Yellow
local git_diverged_color="%F{magenta}" # Magenta
local git_staged_color="%F{green}"     # Green
local git_modified_color="%F{yellow}"  # Yellow
local git_untracked_color="%F{red}"    # Red
local git_stashed_color="%F{cyan}"     # Cyan
local git_conflicts_color="%F{red}"    # Red
local git_warning_color="%F{red}"      # Red
local reset_color="%f"                 # Reset

function printable_or_fallback() {
  local test_char="$1"
  local fallback="$2"

  # zsh: test-width > 0 when symbol is printable
  if [[ ${#${(%)test_char}} -gt 0 ]]; then
    echo "$test_char"
  else
    echo "$fallback"
  fi
}

# === Symbol Definitions ===
# Directory symbol
SYMBOL_PROMPT=$(printable_or_fallback "" "➜")
# Git symbols
SYMBOL_GIT_BRANCH=$(printable_or_fallback "" "") # ⎇
SYMBOL_GIT_CLEAN=$(printable_or_fallback "" "✔")
SYMBOL_AHEAD=$(printable_or_fallback "" "↑")
SYMBOL_BEHIND=$(printable_or_fallback "" "↓")
SYMBOL_DIVERGED=$(printable_or_fallback "󰙁" "↑↓")
SYMBOL_STAGED=$(printable_or_fallback "󰓎" "*")
SYMBOL_MODIFIED=$(printable_or_fallback "" "M")
SYMBOL_UNTRACKED=$(printable_or_fallback "" "?")
SYMBOL_STASHED=$(printable_or_fallback "󰆓" "$")
SYMBOL_CONFLICTS=$(printable_or_fallback "" "!!")

# === Main Git Status Function ===
function custom_git_status() {
  # Check if we're in a git repository
  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    return
  fi

  # Get branch name or commit hash
  local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

  # Start building output
  local output=" on ${git_branch_color}${SYMBOL_GIT_BRANCH} ${branch}${reset_color}"

  # === Check Upstream Status (Push/Pull) ===
  local upstream=$(git rev-parse --abbrev-ref @{upstream} 2>/dev/null)
  if [[ -n "$upstream" ]]; then
    local ahead=$(git rev-list --count @{upstream}..HEAD 2>/dev/null)
    local behind=$(git rev-list --count HEAD..@{upstream} 2>/dev/null)

    if [[ "$ahead" -gt 0 ]] && [[ "$behind" -gt 0 ]]; then
      output+=" ${git_diverged_color}${ahead}/${behind}${SYMBOL_DIVERGED}${reset_color}"
    elif [[ "$ahead" -gt 0 ]]; then
      output+=" ${git_sync_color}${ahead}${SYMBOL_AHEAD}${reset_color}"
    elif [[ "$behind" -gt 0 ]]; then
      output+=" ${git_sync_color}${behind}${SYMBOL_BEHIND}${reset_color}"
    fi
  else
    # Show a warning if there's no upstream set
    output+=" ${git_warning_color}no-up${reset_color}"
  fi

  # === Check Working Tree Status ===
  local staged=0
  local modified=0
  local untracked=0
  local conflicts=0

  # Parse git status porcelain output
  while IFS= read -r line; do
    case "${line:0:2}" in
      "??") ((untracked++)) ;;
      "UU"|"AA"|"DD") ((conflicts++)) ;;
      "M "|"A "|"D "|"R "|"C ") ((staged++)) ;;
      " M"|" D") ((modified++)) ;;
      "MM"|"AM"|"RM") ((staged++)); ((modified++)) ;;
    esac
  done < <(git status --porcelain -uall 2>/dev/null)

  # === Show Status Indicators ===
  local has_changes=false

  if [[ $conflicts -gt 0 ]]; then
    output+=" ${git_conflicts_color}${conflicts}${SYMBOL_CONFLICTS}${reset_color}"
    has_changes=true
  fi

  if [[ $staged -gt 0 ]]; then
    output+=" ${git_staged_color}${staged}${SYMBOL_STAGED}${reset_color}"
    has_changes=true
  fi

  if [[ $modified -gt 0 ]]; then
    output+=" ${git_modified_color}${modified}${SYMBOL_MODIFIED}${reset_color}"
    has_changes=true
  fi

  if [[ $untracked -gt 0 ]]; then
    output+=" ${git_untracked_color}${untracked}${SYMBOL_UNTRACKED}${reset_color}"
    has_changes=true
  fi

  # Check for stashes
  local stash_count=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
  if [[ $stash_count -gt 0 ]]; then
    output+=" | ${git_stashed_color}${stash_count}${SYMBOL_STASHED}${reset_color}"
  fi

  # === Overall Clean/Dirty Indicator ===
  if [[ "$has_changes" == "false" ]]; then
    output+=" ${git_clean_color}${SYMBOL_GIT_CLEAN}${reset_color}"
  fi

  echo "$output"
}

# === Left Prompt ===
PROMPT='${dir_color}%~${reset_color}$(custom_git_status)
${dir_color} ${SYMBOL_PROMPT}${reset_color} '

# === Right Prompt ===
RPROMPT='%F{240}%D{%H:%M:%S}%f'
