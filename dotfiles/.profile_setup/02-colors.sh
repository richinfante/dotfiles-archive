#!/bin/bash

# Colors
if [ "$COLORS_ENABLED" != "false" ]; then
  export RED="\033[31m"
  export LIGHT_RED="\033[91m"
  export YELLOW="\033[33m"
  export LIGHT_YELLOW="\033[93m"
  export GREEN="\033[32m"
  export LIGHT_GREEN="\033[92m"
  export BLUE="\033[34m"
  export LIGHT_BLUE="\033[94m"
  export MAGENTA="\033[35m"
  export LIGHT_MAGENTA="\033[95m"
  export CYAN="\033[36m"
  export LIGHT_CYAN="\033[96m"
  export WHITE="\033[97m"
  export GRAY="\033[37m"
  export BLACK="\033[30m"
  export DEFAULT="\033[39m"
  
  export BG_DEFAULT="\033[49m"
  export BG_BLACK="\033[40m"
  export BG_RED="\033[41m"
  export BG_GREEN="\033[42m"
  export BG_YELLOW="\033[43m"
  export BG_BLUE="\033[44m"
  export BG_MAGENTA="\033[45m"
  export BG_CYAN="\033[46m"
  export BG_LIGHT_GRAY="\033[47m"
  export BG_GRAY="\033[100m"
  export BG_LIGHT_RED="\033[101m"
  export BG_LIGHT_GREEN="\033[102m"
  export BG_LIGHT_YELLOW="\033[103m"
  export BG_LIGHT_BLUE="\033[104m"
  export BG_LIGHT_MAGENTA="\033[105m"
  export BG_LIGHT_CYAN="\033[106m"
  export BG_WHITE="\033[107m"

  export RESET="\033[0m"
  export BOLD="\033[1m"
  export DIM="\033[2m"
  export UNDERLINE="\033[4m"
  export BLINK="\033[5m"
  export INVERTED="\033[7m"
  export HIDDEN="\033[8m"

  # Settings for $PS1 string
  GIT_COLOR="$LIGHT_BLUE"
  DATE_COLOR="$DIM$GRAY"
  HOST_COLOR="$BOLD$WHITE"
  SHELL_TYPE_COLOR="$GREEN"

  # Enable some colors for various prompts
  export CLICOLOR=1
  export LSCOLORS="exfxcxdxbxegedabagacad"
  export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
  export GREP_OPTIONS='--color=auto'
fi 
