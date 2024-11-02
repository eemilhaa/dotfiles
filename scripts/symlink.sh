#!/bin/bash

mkdir -p ~/.config/

symlink_dir_content () {
  shopt  -s dotglob  # match hidden
  for content in "${1}"/* ; do
    if [ -f "${content}" ] || [ -d "${content}" ]; then  # only files or dirs
      echo "${content}"
      ln -s "${content}" "${2}"
    fi
  done
}

symlink_dir_content ~/dotfiles/confs/.config ~/.config/
symlink_dir_content ~/dotfiles/confs/home ~/
