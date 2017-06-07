export TERM=xterm

# export PS1="\u \w \$ "
parse_git_branch() {
  if [ ! -d ".git" ]; then
    # Control will enter here if $DIRECTORY doesn't exist.
    echo ""
  elif git diff-index --quiet HEAD --; then
    # no changes
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(↳\1) /'
  else
    # changes
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(↳\1 \*) /'
  fi
  
}

ssh_status () {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    echo "\[\033[38;5;12m\]\h\[$(tput sgr0)\] "
  fi
  echo ""
}

export PS1="\n$(ssh_status)\u \[$(tput sgr0)\]\[\033[38;5;249m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[\033[38;5;201m\]\$(parse_git_branch)\[$(tput sgr0)\]\\[$(tput sgr0)\]\[\033[38;5;82m\]\$\[$(tput sgr0)\] "

export CLICOLOR=1
# export LSCOLORS=GxFxCxDxBxegedabagaced
export LSCOLORS=hxfxcxdxbxegedabagacad

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'
#alias ls='ls --color=auto'

# Path variables
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/9.6/bin"
export PATH="$PATH:./node_modules/.bin"
export PATH="$PATH:~/.npm-global/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:/Users/rich/bin/emsdk-portable:/Users/rich/bin/emsdk-portable/clang/e1.37.9_64bit:/Users/rich/bin/emsdk-portable/node/4.1.1_64bit/bin:/Users/rich/bin/emsdk-portable/emscripten/1.37.9"

## Shortcuts
alias finder='open .'
alias la='ls -a'
alias ls='ls -GFh'
alias root='sudo su'
alias serve='python -m SimpleHTTPServer 8888'

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

function youtube-mp3 {
  youtube-dl --extract-audio --audio-format mp3 -l $@
}

sha1() { openssl sha1 $@; }
speak() { say -v 'Samantha' $@; }

# Bash auto complete tab cycle
bind 'TAB:menu-complete'

# Shortcut for projects directory
p() { cd ~/Projects/$@; }

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:/Applications/Postgres.app/Contents/Versions/9.6/bin:./node_modules/.bin:~/.npm-global/bin:/Users/rich/bin:/Users/rich/bin/emsdk-portable:/Users/rich/bin/emsdk-portable/clang/e1.37.9_64bit:/Users/rich/bin/emsdk-portable/node/4.1.1_64bit/bin:/Users/rich/bin/emsdk-portable/emscripten/1.37.9:/Users/rich/.vimpkg/bin
