echo "Welcome back, $USER"

# export PS1="\u \w \$ "
export PS1="\u \[$(tput sgr0)\]\[\033[38;5;249m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;82m\]\\$\[$(tput sgr0)\] "

export CLICOLOR=1
# export LSCOLORS=GxFxCxDxBxegedabagaced
export LSCOLORS=hxfxcxdxbxegedabagacad

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/9.6/bin"
alias la='ls -a'
alias ls='ls -GFh'
alias root='sudo su'

