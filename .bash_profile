export TERM=xterm

# Bash tab completion
bind 'TAB:menu-complete'

# export PS1="\u \w \$ "
parse_git_branch() {
  if [ ! -d ".git" ]; then
    # Control will enter here if $DIRECTORY doesn't exist.
    echo ""
  elif git diff-index --quiet HEAD -- 2> /dev/null; then
    # no changes
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(↳ \1) /'
  else
    # changes
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(↳ \1 \*) /'
  fi
  
}

# Return the hostname for display if on ssh
ssh_status () {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    echo "\[\033[38;5;12m\]\h\[$(tput sgr0)\] "
  fi
  echo ""
}

# Bash Prompt
export PS1="\n$(ssh_status 2> /dev/null)\u \[$(tput sgr0)\]\[\033[38;5;249m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[\033[38;5;201m\]\$(parse_git_branch 2> /dev/null)\[$(tput sgr0)\]\\[$(tput sgr0)\]\[\033[38;5;82m\]\$\[$(tput sgr0)\] "

# Enable some colors
export CLICOLOR=1
export LSCOLORS=hxfxcxdxbxegedabagacad
export GREP_OPTIONS='--color=auto'
#alias ls='ls --color=auto'

# Path variables
export PATH="/bin"
export PATH="$PATH:/sbin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:/usr/sbin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/9.6/bin"
export PATH="$PATH:./node_modules/.bin"
export PATH="$PATH:$HOME/.npm-global/bin"
export PATH="$PATH:$HOME/.fastlane/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/bin/emsdk-portable"
export PATH="$PATH:$HOME/bin/emsdk-portable/clang/e1.37.9_64bit"
export PATH="$PATH:$HOME/bin/emsdk-portable/node/4.1.1_64bit/bin"
export PATH="$PATH:$HOME/bin/emsdk-portable/emscripten/1.37.9"

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

# Self Updater
function reload_profile {
  source ~/.bash_profile NO_CHECK_UPDATES
}

function update_dotfiles {
  (
    if [ -d ~/Projects/dotfiles ]; then
      (
        echo "[+] Updating Dotfiles..."
        cd ~/Projects/dotfiles
        git pull &&
        echo "[+] Applying Updates..." &&
        chmod +x ./apply.sh && 
        ./apply.sh
        echo "[+] Run reload_profile to update current shell's profile."
      )
    fi
  )
}

function dotfiles_check_updates {
  if [[ $1 = "NO_CHECK_UPDATES" || $2 == "NO_CHECK_UPDATES" ]]; then
    return "[+] Reloaded profile."
  elif [ -d ~/Projects/dotfiles ]; then
    # Pull Remote refs
    ( cd ~/Projects/dotfiles && git remote update > /dev/null 2> /dev/null ) 
    
    # Check for changes
    UPSTREAM=${1:-'@{u}'}
    LOCAL=$(cd ~/Projects/dotfiles && git rev-parse @)
    REMOTE=$(cd ~/Projects/dotfiles && git rev-parse "$UPSTREAM")
    BASE=$(cd ~/Projects/dotfiles && git merge-base @ "$UPSTREAM")
  
    if [[ "$LOCAL" == "$BASE" && "$LOCAL" != "$REMOTE" ]]; then
        update_dotfiles &
    else
        echo "[+] Dotfiles are up to date."
    fi
  fi
}

dotfiles_check_updates
