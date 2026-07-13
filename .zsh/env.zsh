# ============================================
# Environment Variables
# ============================================
export EDITOR='nano'
export VISUAL='nano'
export LANG=en_US.UTF-8

# Theme settings
# Set THEME_NERD_FONT to 1 to enable Nerd Font symbols, or 0 to use fallback symbols.
# If set to 1, this symbol is printed: , otherwise this symbol is printed: >
export THEME_NERD_FONT="1"

# Colored man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Add custom paths if needed
# export PATH="$HOME/bin:$PATH"
path=($HOME/.npm-global/bin $path)
PATH="$PATH:/home/ivank/.dotnet/tools"

# Setup Android Studio environment variables(OPTIONAL - only if you have Android Studio installed)
export PATH="$PATH:/usr/local/android-studio/bin"
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
