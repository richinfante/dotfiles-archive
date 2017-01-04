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

export PS1="\n\u \[$(tput sgr0)\]\[\033[38;5;249m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[\033[38;5;201m\]\$(parse_git_branch)\[$(tput sgr0)\]\\[$(tput sgr0)\]\[\033[38;5;82m\]\$\[$(tput sgr0)\] "

export CLICOLOR=1
# export LSCOLORS=GxFxCxDxBxegedabagaced
export LSCOLORS=hxfxcxdxbxegedabagacad

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

# Path variables
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/9.6/bin"
export PATH="$PATH:./node_modules/.bin"
## Shortcuts

alias finder='open .'
alias la='ls -a'
alias ls='ls -GFh'
alias root='sudo su'
alias serve='python -m SimpleHTTPServer 8000'

up() {
   if [ -e package.json ]; then
      npm start
   elif [ -e start.sh ]; then
      start.sh
   elif [ -e index.js ]; then
      node index.js
   elif [ -e _config.yml ]; then
      jekyll serve
   elif [ -e index.html ]; then
      open index.html
   else
      echo "No runnable file found."
    fi
}

sha1() { openssl sha1 $@; }

# Shortcut for projects directory
p() { cd ~/Projects/$@; }

# Time utility
now() { node -e "function daydiff(first, second) { return Math.round((second-first)/(1000*60*60*24)); } console.log('Day ' + daydiff(new Date('2016-11-02'), new Date()) + ' - ' + (() => { var now = new Date(); var frac = now.getHours() + now.getMinutes() / 60 + now.getSeconds() / 60 / 60; return (frac / 24 * 100).toFixed(2) + '%'; })());"; }

echo "Welcome back, $USER"
now
