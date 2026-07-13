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

# Set default value for THEME_NERD_FONT if not already configured/exported
: ${THEME_NERD_FONT:="0"}
# You can change THEME_NERD_FONT in your .zshrc or env.zsh to control whether to use Nerd Font symbols (1) or fallback symbols (0).

function symbol_or_fallback() {
  local nerd_symbol="$1"
  local fallback_symbol="$2"

  # if (( THEME_NERD_FONT )); then
  if [[ "$THEME_NERD_FONT" == "1" ]]; then
    print -r -- "$nerd_symbol"
  else
    print -r -- "$fallback_symbol"
  fi
}

# === Symbol Definitions ===
# https://www.nerdfonts.com/cheat-sheet
# Directory symbol
SYMBOL_PROMPT=$(symbol_or_fallback "" "➜")
# Git symbols
SYMBOL_GIT_BRANCH=$(symbol_or_fallback "" ">")
SYMBOL_GIT_CLEAN=$(symbol_or_fallback "" "✔")
SYMBOL_AHEAD=$(symbol_or_fallback "" "↑")
SYMBOL_BEHIND=$(symbol_or_fallback "" "↓")
SYMBOL_DIVERGED=$(symbol_or_fallback "󰙁" "↑↓")
SYMBOL_STAGED=$(symbol_or_fallback "󰓎" "*")
SYMBOL_MODIFIED=$(symbol_or_fallback "" "M")
SYMBOL_UNTRACKED=$(symbol_or_fallback "" "?")
SYMBOL_STASHED=$(symbol_or_fallback "󰆓" "$")
SYMBOL_CONFLICTS=$(symbol_or_fallback "" "!!")

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
    local ahead=$(git rev-list --count @{upstream}..HEAD 2>/dev/null || echo 0)
    local behind=$(git rev-list --count HEAD..@{upstream} 2>/dev/null || echo 0)

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
  local staged=0 # Count of staged changes
  local modified=0 # Count of modified but unstaged changes
  local untracked=0 # Count of untracked files
  local conflicts=0 # Count of merge conflicts

  # Parse git status porcelain output
  while IFS= read -r line; do
    local git_status="${line:0:2}"

    case "$git_status" in
      "??")
        ((untracked++))
        ;;

      "DD"|"AU"|"UD"|"UA"|"DU"|"AA"|"UU")
        ((conflicts++))
        ;;

      *)
        if [[ "${git_status:0:1}" != " " && "${git_status:0:1}" != "?" ]]; then
          ((staged++))
        fi

        if [[ "${git_status:1:1}" != " " ]]; then
          ((modified++))
        fi
        ;;
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
