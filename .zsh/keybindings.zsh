# ============================================
# Key Bindings
# ============================================

# ESC ESC to add/remove sudo
sudo-command-line() {
    [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line
bindkey "\e\e" sudo-command-line

# Ctrl+Arrow keys for word navigation
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Home and End keys - Jump to beginning/end of line
bindkey "^[[H" beginning-of-line      # Home key
bindkey "^[[F" end-of-line            # End key
bindkey "^[[1~" beginning-of-line     # Home (alternative)
bindkey "^[[4~" end-of-line           # End (alternative)
bindkey "^[OH" beginning-of-line      # Home in tmux
bindkey "^[OF" end-of-line            # End in tmux

# Delete key
bindkey "^[[3~" delete-char           # Delete key

# Ctrl+U to delete from cursor to beginning of line
bindkey "^U" backward-kill-line

# Ctrl+K to delete from cursor to end of line
bindkey "^K" kill-line

# Ctrl+W to delete previous word
bindkey "^W" backward-kill-word

# Alt+Backspace to delete previous word (alternative)
bindkey "^[^?" backward-kill-word
