#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )
echo "Copying dotfiles from \"$parent_path\""
cd "$parent_path"
cp ./.hyper.js ~/.hyper.js
cp ./.vimrc ~/.vimrc
cp ./.bash_profile ~/.bash_profile
