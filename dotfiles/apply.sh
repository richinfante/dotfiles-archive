#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )
echo "[+] Copying dotfiles from \"$parent_path\""
cd "$parent_path"

set -x
mkdir -p ~/.vim
mkdir -p ~/.vim/colors
cp molokai-vim/colors/molokai.vim ~/.vim/colors

cp ./.tmux.conf ~/.tmux.conf
cp ./.hyper.js ~/.hyper.js
cp ./.vimrc ~/.vimrc
cp ./.bash_profile ~/.bash_profile
cp ./.bashrc ~/.bashrc

cp -r ./.config ~/.config
cp -r ./scripts ~/scripts

set +x
echo "[+] Applying changes..."

source ~/.bash_profile