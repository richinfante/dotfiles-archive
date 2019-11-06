#!/bin/bash

# Stop python from being annoying.
export PYTHONDONTWRITEBYTECODE="true"
export HISTCONTROL="ignoreboth"

# Customizable Options
GIT_BRANCH_CHAR="↳"
PROMPT_GIT="true"
PROMPT_DATE="false"
ENABLE_HOST_ALWAYS="true"

# If we're in a tty, set some config options
if [ -t 1 ] ; then
  export TERM=xterm-256color
  export COLORS_ENABLED=true

  # Bash tab completion
  bind 'TAB:menu-complete'
fi

# Run Bash config
if [ -f ~/.bash_config ]; then
  source ~/.bash_config
fi
