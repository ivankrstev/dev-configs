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


alias gst='git status'
alias gaa='git add --all'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gp='git push'
alias gpl='git pull'
alias gf='git fetch'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gs='git status -sb'
alias gm='git merge'
alias grb='git rebase'
alias grbi='git rebase -i'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias gsta='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gstd='git stash drop'
alias gclean='git clean -fd'
alias greset='git reset --hard'
