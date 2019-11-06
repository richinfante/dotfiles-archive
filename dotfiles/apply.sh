#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )
echo "[+] Copying dotfiles from \"$parent_path\""
cd "$parent_path"

set -x
mkdir -p ~/.vim
mkdir -p ~/.vim/colors
cp molokai-vim/colors/molokai.vim ~/.vim/colors

function link_path() {
  if [ ! -f "~/$@" ]; then
    ln -s "$(realpath "$@")" "~/$@"
  else
    echo "failed to link: ~/$@ - please remove or rename!"
  fi
}

link_path .tmux.conf
link_path .hyper.js
link_path .vimrc
link_path .bash_profile
link_path .bashrc

cp -r ./.config ~/.config
cp -r ./scripts ~/scripts

set +x
echo "[+] Applying changes..."

source ~/.bash_profile