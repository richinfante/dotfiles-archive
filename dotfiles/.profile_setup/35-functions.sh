#!/bin/bash

# Shortcut to make GPG forget cached passwords.
function gpg-forget { echo RELOADAGENT | gpg-connect-agent; }

# Open in projects folder
function p { cd ~/Projects/$@; }

# Create and open a directory
function cf { mkdir $@; cd $@; }

# youtube-mp3
function youtube-mp3 { youtube-dl --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s" "$@"; }
function youtube-wav { youtube-dl --extract-audio --audio-format wav -o "%(title)s.%(ext)s" "$@"; }

# Download linked files of type.
# Usage: dl-linked mp3,mp4 http://example.com
function dl-linked {
  wget --accept "$1" --mirror --page-requisites --adjust-extension --convert-links --backup-converted --no-parent "$2";
}

# Hash + Crypto functions
function sha1 { openssl sha1 $@; }
function sha256 { shasum -a 256 $@; }
function random-bytes { openssl rand -hex $@; }

# Start and attach a docker instance.
function dvm { docker start $@ 1>/dev/null; docker attach $@; }

# Set window title (iTerm)
function title { echo -ne "\033]0;"$*"\007"; }

# DuckDuckGo
function ddg () {
  w3m "https://duckduckgo.com/lite?q=$*&fd=-1"
}

# Run a command, loading environment variables from and dotenv file
# sets $PATH by default, can override in .env file
function run-env () {
  env -i PATH="$PATH" $(egrep -v '^#' .env | xargs) $@
}

#
# adapted from: https://github.com/dylanaraps/pure-bash-bible
#
urlencode() {
  # check if arg 1 is present. if not, read from stdin.
  if [ "$1" != "" ]; then
    CONTENTS="$1"
  else
    CONTENTS=$(cat -)
  fi

  # Usage: urlencode "string"
  local LC_ALL=C
  for (( i = 0; i < ${#CONTENTS}; i++ )); do
    : "${CONTENTS:i:1}"
    case "$_" in
      [a-zA-Z0-9.~_-])
        printf '%s' "$_"
      ;;

      *)
        printf '%%%02X' "'$_"
      ;;
    esac
  done
  printf '\n'
}

#
# adapted from: https://github.com/dylanaraps/pure-bash-bible
#
urldecode() {
  # check if arg 1 is present. if not, read from stdin.
  if [ "$1" != "" ]; then
    CONTENTS="$1"
  else
    CONTENTS=$(cat -)
  fi

  # Usage: urldecode "string"
  : "${CONTENTS//+/ }"
  printf '%b\n' "${_//%/\\x}"
}
