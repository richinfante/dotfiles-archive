echo "Welcome back, $USER"

# export PS1="\u \w \$ "
export PS1="\n\u \[$(tput sgr0)\]\[\033[38;5;249m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;82m\]\\$\[$(tput sgr0)\] "

export CLICOLOR=1
# export LSCOLORS=GxFxCxDxBxegedabagaced
export LSCOLORS=hxfxcxdxbxegedabagacad

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

# Path variables
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/9.6/bin"

## Shortcuts

alias la='ls -a'
alias ls='ls -GFh'
alias root='sudo su'

# Shortcut for projects directory
p() { cd ~/Projects/$@; }

# Python static serve
alias serve='python -m SimpleHTTPServer 8000'
