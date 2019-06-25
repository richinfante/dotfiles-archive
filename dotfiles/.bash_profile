# Customizable Options
GIT_BRANCH_CHAR="↳"
PROMPT_GIT="true"
PROMPT_DATE="false"
ENABLE_HOST_ALWAYS="true"

# If we're in a tty,
if [ -t 1 ] ; then
  export TERM=xterm-256color
  COLORS_ENABLED=true
  # Bash tab completion
  bind 'TAB:menu-complete'
fi

# Run Bash config
if [ -f ~/.bash_config ]; then
  source ~/.bash_config
fi

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
fi 

# Debian CHROOT Support
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# Bash Prompt String
export PS1="\[$RESET\]\$(\
  $(
    # DATE SECTION
    # This is run on every newline
  )\
  if [[ \"\$PROMPT_DATE\" == \"true\" ]]; then\
   echo \"\[$DATE_COLOR\]\D{%Y-%m-%d %H:%M:%S} \";\
  else\
    echo \"\";
  fi\
)\
$(
  # HOST SECTION
  # (hidden if not using ssh or remote)
)\
\[$RESET\]\[$HOST_COLOR\]\
${debian_chroot:+($debian_chroot) }\u\$(\
 if [ ! -z \"$SSH_CLIENT\" ] || \
    [ ! -z \"$SSH_TTY\" ] || \
    [ -f /.dockerenv ]; then \
  echo "@\\h";\
 fi
): \
$(
  # USER NAME
)\
\[\]\w \
$(
  # GIT COMPONENT
  # Attempt to get git branch
  # Errors piped to stdout so if no branch, no display.
)\
\[$GIT_COLOR\]\$(\
  if [[ \"\$PROMPT_GIT\" == "true" ]]; then\
    if git diff-index --quiet HEAD -- 2> /dev/null; then\
      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/('"$GIT_BRANCH_CHAR"' \1) /';\
    else \
      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/('"$GIT_BRANCH_CHAR"' \1 \*) /';\
    fi\
  fi\
)\
$(
  # SHELL TYPE INDICATOR
  # "$" or "#" depending on user/superuser
)\
\[$SHELL_TYPE_COLOR\]\$(\
  if [[ `whoami` == "root" ]]; then \
    echo '#'; \
    else echo '$';\
  fi\
)\[$RESET\] "

export PS2="\[$DIM$GRAY\]> \[$RESET\]"
export PS4="\[$DIM$GRAY\]+ \[$RESET\]"

# Enable some colors
if [ "$COLORS_ENABLED" != "false" ]; then
  export CLICOLOR=1
  export LSCOLORS=hxfxcxdxbxegedabagacad
  export GREP_OPTIONS='--color=auto'
  # alias ls='ls --color=auto'
fi

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

# Add git completion
if [ -f ~/scripts/git-completion.bash ]; then
  source ~/scripts/git-completion.bash
fi

# Shortcuts
alias finder='open .'
alias l='ls -a'
alias ll='ls -l'
alias la='ls -la'
alias root='sudo su'
alias serve='python -m SimpleHTTPServer 8888'
alias prettyjson='python -m json.tool'
alias c='code'
alias s='subl'
alias t='tmux new-session -A -s main'
alias pdb='python -m pdb'
alias lowercase='tr "[:upper:]" "[:lower:]"'
alias uppercase='tr "[:lower:]" "[:upper:]"'
alias trim="awk '{\$1=\$1};1'"

# GPG Support
GPG_TTY=$(tty)
export GPG_TTY 

# Shortcut to make GPG forget cached passwords.
function gpg-forget { echo RELOADAGENT | gpg-connect-agent; }

# Open in projects folder
function p { cd ~/Projects/$@; }

# Create and open a directory
function cf { mkdir $@; cd $@; }

# youtube-mp3
function youtube-mp3 { youtube-dl --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s" $@; }
function youtube-wav { youtube-dl --extract-audio --audio-format wav -o "%(title)s.%(ext)s" $@; }

# Hash + Crypto functions
function sha1 { openssl sha1 $@; }
function sha256 { shasum -a 256 $@; }
function random-bytes { openssl rand -hex $@; }

# Start and attach a docker instance.
function dvm { docker start $@ 1>/dev/null; docker attach $@; }

# Set window title (iTerm)
function title { echo -ne "\033]0;"$*"\007"; }

# Stop python from being annoying.
export PYTHONDONTWRITEBYTECODE="true"

# Bash History Setup
# This must be the last thing or history is crowded with environment setup.
set -o history
shopt -s histappend
export HISTCONTROL=ignoreboth
export HISTFILE=~/.bash_history
export HISTTIMEFORMAT="%F-%R "
