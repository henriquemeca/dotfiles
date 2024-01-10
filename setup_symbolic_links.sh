#!/bin/bash

### Add symlinks to all "./config" subfolders
for dir in $(find "config" -maxdepth 1 -mindepth 1 -type d); do
    target_dir="$HOME/.$dir"
   if [[ -h $target_dir ]]; then
       echo "Symbolic link for $dir already exists in $target_dir" 
   else
       echo "Creating symbolic link for $target_dir folder"
       ln -s "$(pwd)/$dir" $target_dir
       echo "Link created"
   fi
done

### Add packer.nvim symbolic link 
nvim_start_path="local/share/nvim/site/pack/packer/start"
nvim_packer_path="$nvim_start_path/packer.nvim"

mkdir -p "$HOME/.$nvim_start_path"
if [[ -h "$HOME/.$nvim_packer_path" ]]; then
    ln -s "$(pwd)/.$nvim_packer_path" "$HOME/.$nvim_packer_path"
    echo "packer.nvim symbolic link created"
else
    echo "Symbolic link for packer.nvim already exists in $HOME/.$nvim_packer_path" 
fi
