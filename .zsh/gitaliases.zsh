# ============================================
# Git Aliases
# ============================================

# Shorten git command
alias g=git

# ============================
# LOG & HISTORY
# ============================
# Colored oneline log with relative date and author
alias gll='git log --oneline --all --pretty=format:"%C(bold yellow)%h%Creset%C(auto)%d%Creset %C(white)%s%Creset %C(cyan)- %ar, %an%Creset"'
# Colored oneline log with file changes (A/M/D status per commit) and relative date
alias glf='git log --oneline --all --pretty=format:"%C(bold yellow)%h%Creset%C(auto)%d%Creset %C(white)%s%Creset %C(cyan)- %ar%Creset" --name-status'
# Beautiful colored commit graph with author, relative date, and all branches
alias glga='git log --graph --all --pretty=format:"%C(bold yellow)%h%Creset -%C(auto)%d%Creset %C(white)%s%Creset %C(cyan)— %ar, %an%Creset" --abbrev-commit'
# Show last commit with stats
alias glast='git log -1 HEAD --stat'

# ============================
# DIFF/VIEW CHANGES
# ============================
# Just diff(show changes)
alias gd='git diff'
# Show staged changes
alias gds='git diff --staged'
# Show changes in a specific file(changes between last commit and working directory(unstaged changes))
alias gdf='git diff' # specify file after alias
# Show changes between last two commits
alias gdl2='git diff HEAD~1 HEAD'
# Show changes introduced by a specific commit
alias gdc1='git diff HEAD~1' # specify commit hash after alias
# Show changes introduced by the last commit
alias gdcL='git diff HEAD~1 HEAD'

# ============================
# BRANCHING & MERGING
# ============================
# List branches with last commit info
alias gbl='git branch -vv'
# Delete local and remote branch
alias gbdm='git branch -d' # specify branch after alias, then run: git push origin --delete <branch>
# Merge a branch into the current branch
alias gmm='git merge' # specify branch after alias
# Rebase current branch onto another branch
alias grbm='git rebase' # specify branch after alias

# ============================
# STASHING
# ============================
# Show status in short format with branch info
alias gs='git status -sb'
alias ga='git add'
alias gaa='git add --all'

# ============================
# RESTORING
# ============================
# Unstage file(s) and discard changes in the working directory
alias gr='git restore'
# Unstage file(s), but keep changes in the working directory
alias grss='git restore --staged'
# Unstage all files and discard changes in the working directory
alias grsa='git restore .'
# Unstage all files, but keep changes in the working directory
alias grssa='git restore --staged .'

# ============================
# COMMITTING
# ============================
alias gc='git commit'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gca='git commit --amend'
# Amend the last commit without changing its message
alias gcan='git commit --amend --no-edit'
alias gsh='git show'

# ============================
# REMOTE REPOSITORY
# ============================
alias gf='git fetch'
alias gp='git push'
alias gpl='git pull'

# ============================
# BRANCHING
# ============================
# List all branches
alias gb='git branch'
# List local and remote branches
alias gba='git branch -a'
# Delete a local branch
alias gbd='git branch -d'
# Switch to another branch
alias gsw='git switch'
# Create and switch to a new branch
alias gsc='git switch -c'

# ============================
# MERGING & REBASING
# ============================
alias gm='git merge'
alias grb='git rebase'
alias grbi='git rebase -i'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'

# ============================
# STASHING
# ============================
alias gsta='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gstd='git stash drop'

# ============================
# CLEANING & RESETTING
# ============================
# Preview untracked files/directories that would be deleted
alias gcleanp='git clean -fdn'
# Delete untracked files/directories
alias gclean='git clean -fd'

# Undo last commit, keep changes staged
alias gundo='git reset --soft HEAD~1'
# Undo last commit, keep changes unstaged
alias gundom='git reset HEAD~1'

# Discard all tracked working-tree and staged changes
alias greset='git reset --hard HEAD'
# Reset current branch to remote version
alias greseto='git reset --hard origin/$(git branch --show-current)'
