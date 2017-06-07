#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )
echo "Copying dotfiles from \"$parent_path\""
cd "$parent_path"

# Copy theme from github
git clone git@github.com:/tomasr/molokai
mkdir -p ~/.vim
mkdir -p ~/.vim/colors
cp molokai/colors/molokai.vim ~/.vim/colors

cp ./.tmux.conf ~/.tmux.conf
cp ./.hyper.js ~/.hyper.js
cp ./.vimrc ~/.vimrc
cp ./.bash_profile ~/.bash_profile
