#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )
echo "Copying dotfiles from \"$parent_path\""
cd "$parent_path"

# Clone theme from github (or just pull it)
git clone git@github.com:/tomasr/molokai 2> /dev/null || (cd molokai && git pull)
mkdir -p ~/.vim
mkdir -p ~/.vim/colors
cp molokai/colors/molokai.vim ~/.vim/colors

cp ./.tmux.conf ~/.tmux.conf
cp ./.hyper.js ~/.hyper.js
cp ./.vimrc ~/.vimrc
cp ./.bash_profile ~/.bash_profile
