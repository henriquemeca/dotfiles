#!/bin/bash

#rm -r ~/.config/nvim
#source_dir="$(pwd)/lazy_vim"
#target_dir="$HOME/.config/nvim/"
#ln -s $source_dir $target_dir

docker run -w /root -it -v .:/repo --rm alpine:edge sh -uelic '
  apk add git lazygit neovim ripgrep alpine-sdk --update
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  cd ~/.config/nvim
  nvim
'
