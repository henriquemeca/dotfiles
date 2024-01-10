#!/bin/bash

create_link() {
   source_dir=$1
   target_dir=$2

   if [[ -h $target_dir ]]; then
       echo "Symbolic link already exists for $source_dir in $target_dir"
   else
       echo "Creating link from $source_dir to $target_dir"
       ln -s $source_dir $target_dir
       echo "Link created"
   fi
}

### Add symlinks to all "./config" subfolders
for dir in $(find "config" -maxdepth 1 -mindepth 1 -type d); do
    source_dir="$(pwd)/$dir" 
    target_dir="$HOME/.$dir"
   
    create_link $source_dir $target_dir

done

### Add packer.nvim symbolic link 
nvim_start_path="local/share/nvim/site/pack/packer/start"
nvim_packer_path="$nvim_start_path/packer.nvim"

source_dir="$(pwd)/$nvim_packer_path"
target_dir="$HOME/.$nvim_packer_path"

mkdir -p "$HOME/.$nvim_start_path"
create_link $source_dir $target_dir

### Add .vimrc
source="$(pwd)/vimrc"
target="$HOME/.vimrc"

create_link $source $target
