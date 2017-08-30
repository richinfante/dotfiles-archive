export TERM=xterm

DOTFILES_DIR="~/Projects/dotfiles"

# Bash tab completion
bind 'TAB:menu-complete'

GIT_BRANCH_CHAR="↳"

# Run bashrc
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
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
fi 

plugin_git_branch () {
  if [ ! -d ".git" ]; then
    # Control will enter here if $DIRECTORY doesn't exist.
    echo ""
  elif git diff-index --quiet HEAD -- 2> /dev/null; then
    # no changes
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/('"$GIT_BRANCH_CHAR"' \1) /'
  else
    # changes
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/('"$GIT_BRANCH_CHAR"' \1 \*) /'
  fi
  
}

# Return the hostname for display if on ssh
plugin_ssh_hostname () {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    echo "@\h"
  fi
  echo ""
}

# Display a "#" for root or a "$" for users.
plugin_root () {
  if [ "`id -u`" -eq 0 ]; then
    echo '#'
  else
    echo '$'
  fi
}

export plugin_git_branch
export plugin_ssh_hostname
export plugin_root

# Bash Prompt
export PS1="\[$RESET$BG_BLACK\]\
\[$DIM$GRAY\]\D{%Y-%m-%d %H:%M:%S} \
\[$RESET$WHITE$BG_BLACK\]\u$(plugin_ssh_hostname): \
\[$GRAY\]\w \
\[$LIGHT_MAGENTA\]\$(plugin_git_branch 2> /dev/null)\
\[$LIGHT_GREEN\]$(plugin_root)\[$RESET\] "

# Enable some colors
export CLICOLOR=1
export LSCOLORS=hxfxcxdxbxegedabagacad
export GREP_OPTIONS='--color=auto'
#alias ls='ls --color=auto'

# Export paths only if they exist.
function export_path {
  if [ -d "$1" ]; then
    export PATH="$PATH:$1"
  fi
}

# Path variables
export PATH="/bin"
export_path "/sbin"
export_path "/usr/bin"
export_path "/usr/sbin"
export_path "/usr/local/bin"
export_path "/Applications/Postgres.app/Contents/Versions/9.6/bin"
export_path "./node_modules/.bin"
export_path "$HOME/.local/bin"
export_path "$HOME/.npm-global/bin"
export_path "$HOME/.fastlane/bin"
export_path "$HOME/bin"
export_path "$HOME/bin/emsdk-portable"
export_path "$HOME/bin/emsdk-portable/clang/e1.37.9_64bit"
export_path "$HOME/bin/emsdk-portable/node/4.1.1_64bit/bin"
export_path "$HOME/bin/emsdk-portable/emscripten/1.37.9"

# Shortcuts
alias finder='open .'
alias la='ls -a'
alias ls='ls -GFh'
alias root='sudo su'
alias serve='python -m SimpleHTTPServer 8888'
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias chrome-canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"
alias chromium="/Applications/Chromium.app/Contents/MacOS/Chromium"

cf() {
  mkdir $@; cd $@;
}

up() {
   if [ -e package.json ]; then
      npm start $@
   elif [ -e start.sh ]; then
      start.sh $@
   elif [ -e .up ]; then
      bash ./.up $@
   elif [ -e index.js ]; then
      node index.js $@
   elif [ -e _config.yml ]; then
      jekyll serve
   elif [ -e index.html ]; then
      open index.html
   else
      echo "No runnable file found."
    fi
}

down() {
  if [ -e .down ]; then
      bash ./.down $@
  elif [ -e stop.sh ]; then
      stop.sh
  fi
}

function youtube_mp3 {
  youtube-dl --extract-audio --audio-format mp3 -l $@
}

sha1() { openssl sha1 $@; }
speak() { say -v 'Samantha' $@; }
p() { cd ~/Projects/$@; }

# Check for updates, don't actually do anything about it.
function dotfiles_check_updates {
  if [ -d $DOTFILES_DIR ]; then
    # Pull Remote refs
    ( cd $DOTFILES_DIR && git remote update > /dev/null 2> /dev/null ) 
    
    # Check for changes
    UPSTREAM=${1:-'@{u}'}
    LOCAL=$(cd $DOTFILES_DIR && git rev-parse @)
    REMOTE=$(cd $DOTFILES_DIR && git rev-parse "$UPSTREAM")
    BASE=$(cd $DOTFILES_DIR && git merge-base @ "$UPSTREAM")
  
    if [[ "$LOCAL" == "$BASE" && "$LOCAL" != "$REMOTE" ]]; then
        echo "[!] There are updates available your dotfiles."
        echo "[!] Run \"cd $DOTFILES_DIR\", \"git pull\", and \"./apply.sh\""
    fi
  fi
}

if [ "$DOTFILES_CHECK_UPDATES" == "true" ]; then
  dotfiles_check_updates &
fi
