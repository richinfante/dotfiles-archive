#!/bin/bash

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
