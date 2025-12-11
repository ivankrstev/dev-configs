# ============================================
# Custom Functions
# ============================================

# Create directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Quick git commit with message
gcq() {
  git add -A && git commit -m "$1"
}

# Quick git add, commit, and push
gacp() {
  git add -A && git commit -m "$1" && git push
}

# Extract any archive
extract() {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Find files by name
ff() {
  find . -type f -iname "*$1*"
}

# Find directories by name
fd() {
  find . -type d -iname "*$1*"
}
