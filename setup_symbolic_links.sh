#!/bin/bash
source_dir=$(pwd)/.config
# Loop over all directories in "./config"
for dir in $(find ".config" -maxdepth 1 -mindepth 1 -type d); do
   if [[ -h "$HOME/$dir" ]]; then
       echo "Symbolic link for $dir already exists"
   else
       echo "Creating symbolic link for $dir folder"
       ln -s "$(pwd)/$dir" "$HOME/$dir"
       echo "Link created"
   fi
done