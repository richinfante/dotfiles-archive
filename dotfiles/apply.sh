#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )
echo "[+] Copying dotfiles from \"$parent_path\""
cd "$parent_path"

set -x
mkdir -p ~/.vim
mkdir -p ~/.vim/colors
cp molokai-vim/colors/molokai.vim ~/.vim/colors
set +x

function link_path() {
  TGT_PATH="$HOME/$@"
  SRC_PATH="$(realpath "$@")"

  if [ -L "$TGT_PATH" ]; then
    if [  "$(stat -f %Y $TGT_PATH)" == "$SRC_PATH" ]; then
      echo "$TGT_PATH: path is ok!"
      return
    fi
  fi


  if [ "$TGT_PATH" == "$SRC_PATH" ]; then
    echo "refusing to link to self!"
    exit 1
  fi

  if [ ! -f "$TGT_PATH" ]; then
    set -x
    ln -s "$SRC_PATH" "$TGT_PATH"
    set +x
  else
    if [ ! -f "$TGT_PATH.old" ]; then
      set -x
      mv "$TGT_PATH" "$TGT_PATH.old"
      ln -s "$SRC_PATH" "$TGT_PATH"
      set +x
      echo "moved existing: $TGT_PATH to $TGT_PATH.old"
    else
      echo "failed to link: $TGT_PATH - please remove or rename!"
      exit 1
    fi
  fi
}

link_path .tmux.conf
link_path .hyper.js
link_path .vimrc
link_path .bash_profile
link_path .bashrc
link_path .profile_setup

cp -r ./.config ~/.config
cp -r ./scripts ~/scripts

# If bash_path does not exist, make it
if [ ! -e ~/.bash_path ]; then
  echo "# use this file to edit your \$PATH" >> ~/.bash_path
fi

echo "[+] Applying changes..."

source ~/.bash_profile