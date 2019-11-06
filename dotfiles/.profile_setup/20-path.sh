#!/bin/bash

# Export paths only if they exist.
function export_path {
  if [ -d "$1" ]; then
    export PATH="$PATH:$1"
  fi
}

# Path variables
export PATH="/usr/local/bin"
export_path "/bin"
export_path "/sbin"
export_path "/usr/bin"
export_path "/usr/sbin"
export_path "/Applications/Postgres.app/Contents/Versions/latest/bin"
export_path "$HOME/.local/bin"
export_path "$HOME/.npm-global/bin"
export_path "$HOME/.fastlane/bin"
export_path "$HOME/.cargo/bin"
export_path "$HOME/bin"
export_path "/Applications/Sublime Text.app/Contents/SharedSupport/bin/"

# Since export_path is conditional, we must add directory-dependent paths here:
export PATH="$PATH:./node_modules/.bin"

# Source custom paths.
if [ -f ~/.bash_path ]; then
  source ~/.bash_path
fi
