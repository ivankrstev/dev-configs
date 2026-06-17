# Fish-like path prefix highlighting for Zsh
# This is a custom implementation inspired by the zsh-path-highlighting plugin, but with a
# focus on highlighting valid path prefixes in a more intuitive way (green for valid, red for invalid).

# Commands that expect a file or directory path as their first argument.
# The highlighter will only activate when one of these commands is typed,
# allowing bare paths like "file.txt" or "somedir" without needing
# a leading / or ~.
local -a _zsh_path_commands
_zsh_path_commands=(
  cd z zz
  ls ll la cat less more head tail touch rm rmdir mkdir cp mv ln file
  vim nvim nano vi code
  grep find locate stat du df wc diff
  source . bash zsh sh
  tar zip unzip gzip gunzip
  chmod chown chgrp
)

_zsh_path_prefix_highlight() {
  # Fish-like path prefix highlighting
  local buf="$BUFFER"
  local word="${buf##* }"       # get the last word (the argument being typed)
  local cmd="${buf%% *}"        # get the command (e.g. cd)
  local start=$(( ${#buf} - ${#word} ))
  local end=${#buf}

  # Remove only our own highlights from the previous redraw, identified by the
  # memo tag "zsh-path-prefix". This avoids clearing zsh-syntax-highlighting's
  # highlights (which use memo=zsh-syntax-highlighting) and prevents stale
  # highlights from persisting when moving to the next word after a path.
  region_highlight=("${(@)region_highlight:#*memo=zsh-path-prefix*}")

    # Don't highlight the command itself
  if [[ "$word" == "$cmd" ]]; then
    return
  fi


  # Only apply to arguments of certain commands (e.g. cd, ls, vim)
  if [[ -z "$word" ]]; then
    return
  fi

  # Skip options like -l, --help — they are not paths and would incorrectly go red
  if [[ "$word" == -* ]]; then
    return
  fi

  # Skip the whole line if it contains pipes or redirections — argument
  # position becomes ambiguous and highlighting would be incorrect
  if [[ "$buf" == *'|'* || "$buf" == *'>'* || "$buf" == *'<'* ]]; then
    return
  fi

  # Only activate for specific commands that expect file/directory arguments
  if ! [[ $_zsh_path_commands[*] == *"$cmd"* ]]; then
    return
  fi

  # Expand ~ to $HOME manually since globs don't expand ~ reliably in all cases.
  local expanded="${word/#\~/$HOME}"

  local -a matches
  matches=( ${~expanded}*(N) )  # glob the path to check if it exists

  # Check if it's a full valid path
#   if [[ -e "${word/#\~/$HOME}" ]]; then
    # return
    # region_highlight+=("$start $end fg=10")

  # Check if it's a valid prefix (any file/dir starts with this)
  if [[ ${#matches} -gt 0 ]]; then
    region_highlight+=("$start $end fg=10,underline,memo=zsh-path-prefix")

  else
    region_highlight+=("$start $end fg=red,memo=zsh-path-prefix")
  fi
}

# Hook into ZLE
autoload -U add-zle-hook-widget
add-zle-hook-widget zle-line-pre-redraw _zsh_path_prefix_highlight
